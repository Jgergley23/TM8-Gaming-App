part of 'send_message_notification_cubit.dart';

@freezed
class SendMessageNotificationState with _$SendMessageNotificationState {
  const factory SendMessageNotificationState.initial() = _Initial;
  const factory SendMessageNotificationState.loading() = _Loading;
  const factory SendMessageNotificationState.loaded() = _Loaded;
  const factory SendMessageNotificationState.error({required String error}) =
      _Error;
}
