part of 'fetch_notifications_cubit.dart';

@freezed
class FetchNotificationsState with _$FetchNotificationsState {
  const factory FetchNotificationsState.initial() = _Initial;
  const factory FetchNotificationsState.loading({
    required List<NotificationResponse> notificationList,
  }) = _Loading;
  const factory FetchNotificationsState.loaded({
    required NotificationPaginatedResponse notification,
  }) = _Loaded;
  const factory FetchNotificationsState.error({
    required String error,
  }) = _Error;
}
