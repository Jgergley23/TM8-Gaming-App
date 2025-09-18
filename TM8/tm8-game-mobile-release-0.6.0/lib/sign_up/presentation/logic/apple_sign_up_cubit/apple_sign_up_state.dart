part of 'apple_sign_up_cubit.dart';

@freezed
class AppleSignUpState with _$AppleSignUpState {
  const factory AppleSignUpState.initial() = _Initial;
  const factory AppleSignUpState.loading() = _Loading;
  const factory AppleSignUpState.loaded({
    required AuthResponse response,
  }) = _Loaded;
  const factory AppleSignUpState.error({required String error}) = _Error;
}
