part of 'send_user_warning_cubit.dart';

@freezed
class SendUserWarningState with _$SendUserWarningState {
  const factory SendUserWarningState.initial() = _Initial;
  const factory SendUserWarningState.loading() = _Loading;
  const factory SendUserWarningState.loaded({
    required List<UserResponse> users,
  }) = _Loaded;
  const factory SendUserWarningState.error({
    required String error,
  }) = _Error;
}
