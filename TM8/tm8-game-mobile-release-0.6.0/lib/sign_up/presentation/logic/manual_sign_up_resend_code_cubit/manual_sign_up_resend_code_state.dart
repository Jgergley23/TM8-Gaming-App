part of 'manual_sign_up_resend_code_cubit.dart';

@freezed
class ManualSignUpResendCodeState with _$ManualSignUpResendCodeState {
  const factory ManualSignUpResendCodeState.initial() = _Initial;
  const factory ManualSignUpResendCodeState.loading() = _Loading;
  const factory ManualSignUpResendCodeState.loaded() = _Loaded;
  const factory ManualSignUpResendCodeState.error({required String error}) =
      _Error;
}
