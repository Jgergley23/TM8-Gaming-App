import 'package:flutter/foundation.dart';
import 'package:tm8_game_admin/app/api/auth_interceptor.dart';
import 'package:tm8_game_admin/app/api/http_logger.dart';
import 'package:tm8_game_admin/app/api/token_interceptor.dart';
import 'package:tm8_game_admin/env/env.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

final api = Swagger.create(
  baseUrl: Uri(
    scheme: 'https',
    host: Env.baseUrl,
  ),
  interceptors: [
    AuthInterceptor(),
    TokenInterceptor(),
    if (kDebugMode) ...[
      const PrettyLoggingInterceptor(level: Level.basic),
    ],
  ],
);
