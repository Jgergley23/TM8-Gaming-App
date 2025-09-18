import 'package:get_it/get_it.dart';

import 'package:injectable/injectable.dart';
import 'package:tm8/app/services/service_locator.config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => sl.init();

@module
abstract class RegisterModule {
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

@module
abstract class SecureStorageModule {
  @singleton
  FlutterSecureStorage get storage {
    const storage = FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
    return storage;
  }
}
