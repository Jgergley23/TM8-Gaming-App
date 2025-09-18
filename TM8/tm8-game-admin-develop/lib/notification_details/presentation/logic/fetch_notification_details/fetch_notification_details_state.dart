part of 'fetch_notification_details_cubit.dart';

@freezed
class FetchNotificationDetailsState with _$FetchNotificationDetailsState {
  const factory FetchNotificationDetailsState.initial() = _Initial;
  const factory FetchNotificationDetailsState.loading() = _Loading;
  const factory FetchNotificationDetailsState.loaded({
    required ScheduledNotificationResponse notificationDetails,
  }) = _Loaded;
  const factory FetchNotificationDetailsState.error({required String error}) =
      _Error;
}
