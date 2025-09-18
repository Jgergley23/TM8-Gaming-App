part of 'fetch_notifications_cubit.dart';

@freezed
class FetchNotificationsState with _$FetchNotificationsState {
  const factory FetchNotificationsState.initial() = _Initial;
  const factory FetchNotificationsState.loading({required int length}) =
      _Loading;
  const factory FetchNotificationsState.loaded({
    required ScheduledNotificationPaginatedResponse
        notificationPaginatedResponse,
    required NotificationTableDataFilters filters,
    required String? message,
  }) = _Loaded;
  const factory FetchNotificationsState.error({required String error}) = _Error;
}
