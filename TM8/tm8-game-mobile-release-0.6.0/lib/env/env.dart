// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'CLIENT_ID')
  static const String clientID = _Env.clientID;
  @EnviedField(varName: 'EPIC_GAMES_URL')
  static const String epicGamesUrl = _Env.epicGamesUrl;
  @EnviedField(varName: 'STREAM_KEY')
  static const String streamKey = _Env.streamKey;
  @EnviedField(varName: 'STREAM_SECRET')
  static const String streamSecret = _Env.streamSecret;
  @EnviedField(varName: 'STAGING_URL')
  static const String stagingUrl = _Env.stagingUrl;
  @EnviedField(varName: 'BASE_URL_AMAZON')
  static const String baseUrlAmazon = _Env.baseUrlAmazon;
  @EnviedField(varName: 'STAGING_URL_AMAZON')
  static const String stagingUrlAmazon = _Env.stagingUrlAmazon;
}
