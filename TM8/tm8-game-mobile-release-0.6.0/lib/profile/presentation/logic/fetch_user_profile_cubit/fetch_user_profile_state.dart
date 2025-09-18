part of 'fetch_user_profile_cubit.dart';

@freezed
class FetchUserProfileState with _$FetchUserProfileState {
  const factory FetchUserProfileState.initial() = _Initial;
  const factory FetchUserProfileState.loading() = _Loading;
  const factory FetchUserProfileState.loaded({
    required GetMeUserResponse userProfile,
  }) = _Loaded;
  const factory FetchUserProfileState.error({required String error}) = _Error;
}
