part of 'edit_notification_cubit.dart';

@freezed
class EditNotificationState with _$EditNotificationState {
  const factory EditNotificationState.initial() = _Initial;
  const factory EditNotificationState.loading() = _Loading;
  const factory EditNotificationState.loaded({
    required ScheduledNotificationResponse editedNotification,
  }) = _Loaded;
  const factory EditNotificationState.error({required String error}) = _Error;
}
