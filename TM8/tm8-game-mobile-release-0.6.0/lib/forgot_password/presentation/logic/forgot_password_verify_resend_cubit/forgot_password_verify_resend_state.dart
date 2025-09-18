part of 'forgot_password_verify_resend_cubit.dart';

@freezed
class ForgotPasswordVerifyResendState with _$ForgotPasswordVerifyResendState {
  const factory ForgotPasswordVerifyResendState.initial() = _Initial;
  const factory ForgotPasswordVerifyResendState.loading() = _Loading;
  const factory ForgotPasswordVerifyResendState.loaded() = _Loaded;
  const factory ForgotPasswordVerifyResendState.error({required String error}) =
      _Error;
}
