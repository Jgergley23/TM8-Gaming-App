import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/storage/tm8_game_admin_storage.dart';

class AuthInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final accessToken = sl<Tm8GameAdminStorage>().accessToken;

    if (accessToken != '') {
      request.headers.addAll({"Authorization": "Bearer $accessToken"});
    }
    //if there is a need for new token
    if (request.url.path.contains('auth/token/refresh')) {
      final refreshToken = sl<Tm8GameAdminStorage>().refreshToken;
      logInfo({"Authorization": "Bearer $refreshToken"});
      request.headers.addAll({"Authorization": "Bearer $refreshToken"});
    }

    return request;
  }
}
