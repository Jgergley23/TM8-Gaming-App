import 'package:flutter/foundation.dart';
import 'package:tm8/app/api/auth_interceptor.dart';
import 'package:tm8/app/api/error_response_interceptor.dart';
import 'package:tm8/app/api/http_logger.dart';
import 'package:tm8/app/api/token_interceptor.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

// api service used throughout the app, change env on changing
// environment
final api = Swagger.create(
  baseUrl: Uri(
    scheme: 'https',
    host: Env.stagingUrl,
  ),
  interceptors: [
    AuthInterceptor(),
    TokenInterceptor(),
    CustomErrorResponseInterceptor(),
    if (kDebugMode) ...[
      const PrettyLoggingInterceptor(level: Level.basic),
    ],
  ],
);
