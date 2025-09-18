part of 'social_sign_up_dob_cubit.dart';

@freezed
class SocialSignUpDobState with _$SocialSignUpDobState {
  const factory SocialSignUpDobState.initial() = _Initial;
  const factory SocialSignUpDobState.loading() = _Loading;
  const factory SocialSignUpDobState.loaded() = _Loaded;
  const factory SocialSignUpDobState.error({required String error}) = _Error;
}
