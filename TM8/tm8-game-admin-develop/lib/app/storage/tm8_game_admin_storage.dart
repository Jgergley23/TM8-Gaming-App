// ignore_for_file: unused_element

import 'package:injectable/injectable.dart';
import 'package:tm8_game_admin/app/storage/storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class Tm8GameAdminStorage {
  Tm8GameAdminStorage(SharedPreferences sharedPreferences)
      : _prefs = sharedPreferences;

  // Getters
  bool get isDarkMode => _prefs.getBool(StorageConstants.isDarkMode) ?? false;

  String get userEmail => _prefs.getString(StorageConstants.userEmail) ?? '';

  String get resetEmail => _prefs.getString(StorageConstants.resetEmail) ?? '';

  String get accessToken =>
      _prefs.getString(StorageConstants.accessToken) ?? '';

  String get refreshToken =>
      _prefs.getString(StorageConstants.refreshToken) ?? '';

  String get userName => _prefs.getString(StorageConstants.userName) ?? '';

  String get userId => _prefs.getString(StorageConstants.userId) ?? '';

  String get userRole => _prefs.getString(StorageConstants.userRole) ?? '';

  // Setters
  set isDarkMode(bool value) => _updateBool(StorageConstants.isDarkMode, value);

  set userEmail(String value) =>
      _updateString(StorageConstants.userEmail, value);

  set resetEmail(String value) =>
      _updateString(StorageConstants.resetEmail, value);

  set accessToken(String value) =>
      _updateString(StorageConstants.accessToken, value);

  set refreshToken(String value) =>
      _updateString(StorageConstants.refreshToken, value);

  set userId(String value) => _updateString(StorageConstants.userId, value);

  set userRole(String value) => _updateString(StorageConstants.userRole, value);

  set userName(String value) => _updateString(StorageConstants.userName, value);

  // Functions
  void _updateBool(String key, bool? value) =>
      value == null ? _prefs.remove(key) : _prefs.setBool(key, value);

  void _updateInt(String key, int? value) =>
      value == null ? _prefs.remove(key) : _prefs.setInt(key, value);

  void _updateString(String key, String? value) =>
      value == null ? _prefs.remove(key) : _prefs.setString(key, value);

  void clear() async {
    await _prefs.clear();
  }

  final SharedPreferences _prefs;
}
