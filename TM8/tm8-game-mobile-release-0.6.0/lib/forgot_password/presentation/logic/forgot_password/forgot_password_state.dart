part of 'forgot_password_cubit.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;
  const factory ForgotPasswordState.loading() = _Loading;
  const factory ForgotPasswordState.loaded({required String phoneNumber}) =
      _Loaded;
  const factory ForgotPasswordState.error({required String error}) = _Error;
}
