part of 'google_sign_up_cubit.dart';

@freezed
class GoogleSignUpState with _$GoogleSignUpState {
  const factory GoogleSignUpState.initial() = _Initial;
  const factory GoogleSignUpState.loading() = _Loading;
  const factory GoogleSignUpState.loaded({
    required AuthResponse response,
  }) = _Loaded;
  const factory GoogleSignUpState.error({required String error}) = _Error;
}
