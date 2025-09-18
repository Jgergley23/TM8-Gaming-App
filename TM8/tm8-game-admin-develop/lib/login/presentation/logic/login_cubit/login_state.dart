part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  // will be removed for loaded
  const factory LoginState.loaded({required String email}) = _Loaded;
  const factory LoginState.error({required String error}) = _Error;
}
