import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/app_bloc/app_bloc.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/router/router.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/storage/tm8_game_admin_storage.dart';

class TokenInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) async {
    if (response.error != null &&
        response.statusCode == 401 &&
        response.base.request?.url !=
            Uri.parse(
              'https://test.api.tm8gaming.com/api/v1/auth/token/refresh',
            )) {
      logInfo('refresh token logic');
      return await _refreshToken(response);
    }
    final now = DateTime.now();
    final yourToken = sl<Tm8GameAdminStorage>().refreshToken;
    if (yourToken != '') {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
      var dt = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      var diff = dt.difference(now).inHours;
      if (diff < 1) {
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
        sl<Tm8GameAdminStorage>().accessToken = result.body?.accessToken ?? '';
        sl<Tm8GameAdminStorage>().refreshToken =
            result.body?.refreshToken ?? '';
        sl<AppRouter>().routerDelegate.beamToNamed(
              home,
            );
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
