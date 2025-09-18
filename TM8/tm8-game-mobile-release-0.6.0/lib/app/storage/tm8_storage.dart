// ignore_for_file: unused_element

import 'package:injectable/injectable.dart';
import 'package:tm8/app/storage/storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class Tm8Storage {
  Tm8Storage(SharedPreferences sharedPreferences) : _prefs = sharedPreferences;

  // Getters
  bool get isUsingBiometrics =>
      _prefs.getBool(StorageConstants.isUsingBiometrics) ?? true;
  bool get isDarkMode => _prefs.getBool(StorageConstants.isDarkMode) ?? false;
  bool get isTablet => _prefs.getBool(StorageConstants.isTablet) ?? false;
  bool get regionCheck => _prefs.getBool(StorageConstants.regionCheck) ?? false;

  bool get firstRunKeyEpicGames =>
      _prefs.getBool(StorageConstants.firstRunKeyEpicGames) ?? false;

  String get accessToken =>
      _prefs.getString(StorageConstants.accessToken) ?? '';

  String get refreshToken =>
      _prefs.getString(StorageConstants.refreshToken) ?? '';

  String get userId => _prefs.getString(StorageConstants.userID) ?? '';

  String get chatToken => _prefs.getString(StorageConstants.chatToken) ?? '';

  String get userName => _prefs.getString(StorageConstants.userName) ?? '';

  String get signupType => _prefs.getString(StorageConstants.signupType) ?? '';

  String get fromOnlineMatchMakingTimeFortnite =>
      _prefs.getString(StorageConstants.fromOnlineMatchMakingTimeFortnite) ??
      '';

  String get toOnlineMatchMakingTimeFortnite =>
      _prefs.getString(StorageConstants.toOnlineMatchMakingTimeFortnite) ?? '';

  String get fromOnlineMatchMakingTimeApex =>
      _prefs.getString(StorageConstants.fromOnlineMatchMakingTimeApex) ?? '';

  String get toOnlineMatchMakingTimeApex =>
      _prefs.getString(StorageConstants.toOnlineMatchMakingTimeApex) ?? '';

  String get fromOnlineMatchMakingTimeCallOfDuty =>
      _prefs.getString(StorageConstants.fromOnlineMatchMakingTimeCallOfDuty) ??
      '';

  String get toOnlineMatchMakingTimeCallOfDuty =>
      _prefs.getString(StorageConstants.toOnlineMatchMakingTimeCallOfDuty) ??
      '';

  String get fromOnlineMatchMakingTimeRocketLeague =>
      _prefs
          .getString(StorageConstants.fromOnlineMatchMakingTimeRocketLeague) ??
      '';

  String get toOnlineMatchMakingTimeRocketLeague =>
      _prefs.getString(StorageConstants.toOnlineMatchMakingTimeRocketLeague) ??
      '';

  String get storedMatchmakingTimeFortnite =>
      _prefs.getString(StorageConstants.storedMatchmakingTimeFortnite) ?? '';

  String get storedMatchmakingTimeApex =>
      _prefs.getString(StorageConstants.storedMatchmakingTimeApex) ?? '';

  String get storedMatchmakingTimeCallOfDuty =>
      _prefs.getString(StorageConstants.storedMatchmakingTimeCallOfDuty) ?? '';

  String get storedMatchmakingTimeRocketLeague =>
      _prefs.getString(StorageConstants.storedMatchmakingTimeRocketLeague) ??
      '';

  String get region =>
      _prefs.getString(StorageConstants.region) ?? 'north-america';

  // Setters
  set isUsingBiometrics(bool value) =>
      _updateBool(StorageConstants.isUsingBiometrics, value);
  set isDarkMode(bool value) => _updateBool(StorageConstants.isDarkMode, value);
  set isTablet(bool value) => _updateBool(StorageConstants.isTablet, value);
  set firstRunKeyEpicGames(bool value) =>
      _updateBool(StorageConstants.firstRunKeyEpicGames, value);
  set regionCheck(bool value) =>
      _updateBool(StorageConstants.regionCheck, value);

  set accessToken(String value) =>
      _updateString(StorageConstants.accessToken, value);
  set refreshToken(String value) =>
      _updateString(StorageConstants.refreshToken, value);
  set userId(String value) => _updateString(StorageConstants.userID, value);
  set chatToken(String value) =>
      _updateString(StorageConstants.chatToken, value);

  set userName(String value) => _updateString(StorageConstants.userName, value);

  set signupType(String value) =>
      _updateString(StorageConstants.signupType, value);

  set fromOnlineMatchMakingTimeFortnite(String value) =>
      _updateString(StorageConstants.fromOnlineMatchMakingTimeFortnite, value);

  set toOnlineMatchMakingTimeFortnite(String value) =>
      _updateString(StorageConstants.toOnlineMatchMakingTimeFortnite, value);

  set fromOnlineMatchMakingTimeApex(String value) =>
      _updateString(StorageConstants.fromOnlineMatchMakingTimeApex, value);

  set toOnlineMatchMakingTimeApex(String value) =>
      _updateString(StorageConstants.toOnlineMatchMakingTimeApex, value);

  set fromOnlineMatchMakingTimeCallOfDuty(String value) => _updateString(
        StorageConstants.fromOnlineMatchMakingTimeCallOfDuty,
        value,
      );

  set toOnlineMatchMakingTimeCallOfDuty(String value) =>
      _updateString(StorageConstants.toOnlineMatchMakingTimeCallOfDuty, value);

  set fromOnlineMatchMakingTimeRocketLeague(String value) => _updateString(
        StorageConstants.fromOnlineMatchMakingTimeRocketLeague,
        value,
      );

  set toOnlineMatchMakingTimeRocketLeague(String value) => _updateString(
        StorageConstants.toOnlineMatchMakingTimeRocketLeague,
        value,
      );

  set storedMatchmakingTimeFortnite(String value) => _updateString(
        StorageConstants.storedMatchmakingTimeFortnite,
        value,
      );

  set storedMatchmakingTimeApex(String value) => _updateString(
        StorageConstants.storedMatchmakingTimeApex,
        value,
      );

  set storedMatchmakingTimeCallOfDuty(String value) => _updateString(
        StorageConstants.storedMatchmakingTimeCallOfDuty,
        value,
      );

  set storedMatchmakingTimeRocketLeague(String value) => _updateString(
        StorageConstants.storedMatchmakingTimeRocketLeague,
        value,
      );

  set region(String value) => _updateString(
        StorageConstants.region,
        value,
      );

  // Functions
  void _updateBool(String key, bool? value) =>
      value == null ? _prefs.remove(key) : _prefs.setBool(key, value);

  void _updateInt(String key, int? value) =>
      value == null ? _prefs.remove(key) : _prefs.setInt(key, value);

  void _updateString(String key, String? value) =>
      value == null ? _prefs.remove(key) : _prefs.setString(key, value);

  void clear() async {
    final firstRun = firstRunKeyEpicGames;
    final region = regionCheck;
    await _prefs.clear();
    firstRunKeyEpicGames = firstRun;
    regionCheck = region;
  }

  void clearAll() async {
    await _prefs.clear();
  }

  final SharedPreferences _prefs;
}
