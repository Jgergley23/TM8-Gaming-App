part of 'verify_change_email_cubit.dart';

@freezed
class VerifyChangeEmailState with _$VerifyChangeEmailState {
  const factory VerifyChangeEmailState.initial() = _Initial;
  const factory VerifyChangeEmailState.loading() = _Loading;
  const factory VerifyChangeEmailState.loaded() = _Loaded;
  const factory VerifyChangeEmailState.error({required String error}) = _Error;
}
