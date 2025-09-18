part of 'send_call_notification_cubit.dart';

@freezed
class SendCallNotificationState with _$SendCallNotificationState {
  const factory SendCallNotificationState.initial() = _Initial;
  const factory SendCallNotificationState.loading() = _Loading;
  const factory SendCallNotificationState.loaded() = _Loaded;
  const factory SendCallNotificationState.error({required String error}) =
      _Error;
}
