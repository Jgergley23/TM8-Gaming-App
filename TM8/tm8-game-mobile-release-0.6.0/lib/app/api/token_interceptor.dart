import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/app_bloc/app_bloc.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/env/env.dart';

// this class contains refresh token logic off the app
// it looks when refresh token expires and then calls endpoint to refresh
class TokenInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) async {
    if (response.error != null &&
        response.statusCode == 401 &&
        response.base.request?.url !=
            Uri.parse(
              'https://${Env.stagingUrl}/api/v1/auth/token/refresh',
            )) {
      logInfo('refresh token logic');
      return await _refreshToken(response);
    }
    final now = DateTime.now();
    final yourToken = sl<Tm8Storage>().accessToken;
    if (yourToken != '') {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
      var dt = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      var diff = dt.difference(now).inMinutes;
      if (diff < 30 &&
          response.base.request?.url !=
              Uri.parse(
                'https://${Env.stagingUrl}/api/v1/auth/token/refresh',
              )) {
        logInfo('refresh token logic');
        return await _refreshToken(response);
      }
    }

    return response;
  }

  Future<Response<dynamic>> _refreshToken(Response<dynamic> response) async {
    try {
      final result = await api.apiV1AuthTokenRefreshPost();

      if (result.isSuccessful) {
        sl<Tm8Storage>().accessToken = result.body?.accessToken ?? '';
        sl<Tm8Storage>().refreshToken = result.body?.refreshToken ?? '';
        sl<Tm8Storage>().chatToken = result.body?.chatToken ?? '';
        sl<AppBloc>().add(const AppEvent.checkStatus());
        // sl<AppRouter>().pushAndPopUntil(
        //   const HomePageRoute(),
        //   predicate: (_) => false,
        // );
        return response;
      } else {
        sl<AppBloc>().add(const AppEvent.logOut());
        return response;
      }
    } catch (e) {
      sl<AppBloc>().add(const AppEvent.logOut());
      return response;
    }
  }
}
