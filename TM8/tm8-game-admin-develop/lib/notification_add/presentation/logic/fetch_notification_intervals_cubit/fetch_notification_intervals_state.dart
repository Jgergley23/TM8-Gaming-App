part of 'fetch_notification_intervals_cubit.dart';

@freezed
class FetchNotificationIntervalsState with _$FetchNotificationIntervalsState {
  const factory FetchNotificationIntervalsState.initial() = _Initial;
  const factory FetchNotificationIntervalsState.loading() = _Loading;
  const factory FetchNotificationIntervalsState.loaded({
    required List<NotificationIntervalResponse> intervals,
  }) = _Loaded;
  const factory FetchNotificationIntervalsState.error({required String error}) =
      _Error;
}
