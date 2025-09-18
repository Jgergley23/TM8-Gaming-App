part of 'update_notifications_settings_cubit.dart';

@freezed
class UpdateNotificationsSettingsState with _$UpdateNotificationsSettingsState {
  const factory UpdateNotificationsSettingsState.initial() = _Initial;
  const factory UpdateNotificationsSettingsState.loading() = _Loading;
  const factory UpdateNotificationsSettingsState.loaded() = _Loaded;
  const factory UpdateNotificationsSettingsState.error({
    required String error,
  }) = _Error;
}
