part of 'manual_login_cubit.dart';

@freezed
class ManualLoginState with _$ManualLoginState {
  const factory ManualLoginState.initial() = _Initial;
  const factory ManualLoginState.loading() = _Loading;
  const factory ManualLoginState.loaded({required AuthResponse response}) =
      _Loaded;
  const factory ManualLoginState.error({
    required String error,
    required String email,
  }) = _Error;
}
