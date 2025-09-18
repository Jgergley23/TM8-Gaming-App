part of 'check_friend_status_cubit.dart';

@freezed
class CheckFriendStatusState with _$CheckFriendStatusState {
  const factory CheckFriendStatusState.initial() = _Initial;
  const factory CheckFriendStatusState.loading() = _Loading;
  const factory CheckFriendStatusState.loaded({
    required CheckFriendshipResponse friendStatus,
  }) = _Loaded;
  const factory CheckFriendStatusState.error({required String error}) = _Error;
}
