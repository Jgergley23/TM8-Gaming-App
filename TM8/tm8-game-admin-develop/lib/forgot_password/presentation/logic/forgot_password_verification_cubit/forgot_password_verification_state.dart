part of 'forgot_password_verification_cubit.dart';

@freezed
class ForgotPasswordVerificationState with _$ForgotPasswordVerificationState {
  const factory ForgotPasswordVerificationState.initial() = _Initial;
  const factory ForgotPasswordVerificationState.loading() = _Loading;
  const factory ForgotPasswordVerificationState.loaded() = _Loaded;
  const factory ForgotPasswordVerificationState.error({
    required String error,
  }) = _Error;
}
