part of 'manual_sign_up_cubit.dart';

@freezed
class ManualSignUpState with _$ManualSignUpState {
  const factory ManualSignUpState.initial() = _Initial;
  const factory ManualSignUpState.loading() = _Loading;
  const factory ManualSignUpState.loaded({required String email}) = _Loaded;
  const factory ManualSignUpState.error({required String error}) = _Error;
}
