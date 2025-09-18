part of 'forgot_password_verify_cubit.dart';

@freezed
class ForgotPasswordVerifyState with _$ForgotPasswordVerifyState {
  const factory ForgotPasswordVerifyState.initial() = _Initial;
  const factory ForgotPasswordVerifyState.loading() = _Loading;
  const factory ForgotPasswordVerifyState.loaded() = _Loaded;
  const factory ForgotPasswordVerifyState.error({required String error}) =
      _Error;
}
