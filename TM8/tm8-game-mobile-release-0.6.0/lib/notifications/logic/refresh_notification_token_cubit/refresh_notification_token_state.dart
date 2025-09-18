part of 'refresh_notification_token_cubit.dart';

@freezed
class RefreshNotificationTokenState with _$RefreshNotificationTokenState {
  const factory RefreshNotificationTokenState.initial() = _Initial;
  const factory RefreshNotificationTokenState.loading() = _Loading;
  const factory RefreshNotificationTokenState.loaded() = _Loaded;
  const factory RefreshNotificationTokenState.error({required String error}) =
      _Error;
}
