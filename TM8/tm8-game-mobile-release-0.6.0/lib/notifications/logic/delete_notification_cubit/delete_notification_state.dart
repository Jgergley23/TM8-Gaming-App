part of 'delete_notification_cubit.dart';

@freezed
class DeleteNotificationState with _$DeleteNotificationState {
  const factory DeleteNotificationState.initial() = _Initial;
  const factory DeleteNotificationState.loading() = _Loading;
  const factory DeleteNotificationState.loaded() = _Loaded;
  const factory DeleteNotificationState.error({
    required String error,
  }) = _Error;
}
