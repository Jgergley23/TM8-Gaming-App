// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'STAGING_BASE_URL')
  static const String stagingBaseURL = _Env.stagingBaseURL;
  @EnviedField(varName: 'BASE_URL_AMAZON')
  static const String baseUrlAmazon = _Env.baseUrlAmazon;
  @EnviedField(varName: 'STAGING_URL_AMAZON')
  static const String stagingUrlAmazon = _Env.stagingUrlAmazon;
}
