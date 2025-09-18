part of 'check_user_cubit.dart';

@freezed
class CheckUserState with _$CheckUserState {
  const factory CheckUserState.initial() = _Initial;
  const factory CheckUserState.loading() = _Loading;
  const factory CheckUserState.loaded({
    required UserProfileResponse profileMatch,
    required GetMeUserResponse profileUser,
  }) = _Loaded;
  const factory CheckUserState.error({required String error}) = _Error;
}
