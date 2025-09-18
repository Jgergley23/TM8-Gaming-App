part of 'read_notification_cubit.dart';

@freezed
class ReadNotificationState with _$ReadNotificationState {
  const factory ReadNotificationState.initial() = _Initial;
  const factory ReadNotificationState.loading() = _Loading;
  const factory ReadNotificationState.loaded() = _Loaded;
  const factory ReadNotificationState.error({required String error}) = _Error;
}
