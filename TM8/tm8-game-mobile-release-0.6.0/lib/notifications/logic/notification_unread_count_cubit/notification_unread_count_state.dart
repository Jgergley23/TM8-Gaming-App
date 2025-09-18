part of 'notification_unread_count_cubit.dart';

@freezed
class NotificationUnreadCountState with _$NotificationUnreadCountState {
  const factory NotificationUnreadCountState.initial() = _Initial;
  const factory NotificationUnreadCountState.loading() = _Loading;
  const factory NotificationUnreadCountState.loaded({
    required UnreadNotificationsResponse notificationCount,
  }) = _Loaded;
  const factory NotificationUnreadCountState.error({
    required String error,
  }) = _Error;
}
