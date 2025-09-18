part of 'forgot_password_reset_cubit.dart';

@freezed
class ForgotPasswordResetState with _$ForgotPasswordResetState {
  const factory ForgotPasswordResetState.initial() = _Initial;
  const factory ForgotPasswordResetState.loading() = _Loading;
  const factory ForgotPasswordResetState.loaded({
    required AuthResponse response,
  }) = _Loaded;
  const factory ForgotPasswordResetState.error({required String error}) =
      _Error;
}
