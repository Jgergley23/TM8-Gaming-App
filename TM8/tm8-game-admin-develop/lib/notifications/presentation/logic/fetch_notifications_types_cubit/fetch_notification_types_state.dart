part of 'fetch_notification_types_cubit.dart';

@freezed
class FetchNotificationTypesState with _$FetchNotificationTypesState {
  const factory FetchNotificationTypesState.initial() = _Initial;
  const factory FetchNotificationTypesState.loading() = _Loading;
  const factory FetchNotificationTypesState.loaded({
    required List<NotificationTypeResponse> notificationTypes,
    required bool validationFailure,
  }) = _Loaded;
  const factory FetchNotificationTypesState.error({required String error}) =
      _Error;
}
