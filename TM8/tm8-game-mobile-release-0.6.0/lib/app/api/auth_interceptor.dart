import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';

// class that adds bearer token and refresh token to headers of endpoints
class AuthInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final accessToken = sl<Tm8Storage>().accessToken;

    if (accessToken != '') {
      request.headers.addAll({
        "Authorization": "Bearer $accessToken",
      });
    }

    if (request.url.path.contains('auth/token/refresh')) {
      final refreshToken = sl<Tm8Storage>().refreshToken;
      logInfo({"Authorization": "Bearer $refreshToken"});
      request.headers.addAll({"Authorization": "Bearer $refreshToken"});
    }

    return request;
  }
}
