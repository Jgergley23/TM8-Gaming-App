part of 'fetch_notification_settings_cubit.dart';

@freezed
class FetchNotificationSettingsState with _$FetchNotificationSettingsState {
  const factory FetchNotificationSettingsState.initial() = _Initial;
  const factory FetchNotificationSettingsState.loading() = _Loading;
  const factory FetchNotificationSettingsState.loaded({
    required List<NotificationSettingsOptionResponse> notificationSettings,
  }) = _Loaded;
  const factory FetchNotificationSettingsState.error({required String error}) =
      _Error;
}
