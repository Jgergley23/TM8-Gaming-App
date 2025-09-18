part of 'manual_sign_up_verify_phone_cubit.dart';

@freezed
class ManualSignUpVerifyPhoneState with _$ManualSignUpVerifyPhoneState {
  const factory ManualSignUpVerifyPhoneState.initial() = _Initial;
  const factory ManualSignUpVerifyPhoneState.loading() = _Loading;
  const factory ManualSignUpVerifyPhoneState.loaded({
    required AuthResponse response,
  }) = _Loaded;
  const factory ManualSignUpVerifyPhoneState.error({required String error}) =
      _Error;
}
