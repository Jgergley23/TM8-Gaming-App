part of 'remove_friend_cubit.dart';

@freezed
class RemoveFriendState with _$RemoveFriendState {
  const factory RemoveFriendState.initial() = _Initial;
  const factory RemoveFriendState.loading() = _Loading;
  const factory RemoveFriendState.loaded() = _Loaded;
  const factory RemoveFriendState.error({required String error}) = _Error;
}
