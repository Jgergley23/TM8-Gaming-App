part of 'add_friend_cubit.dart';

@freezed
class AddFriendState with _$AddFriendState {
  const factory AddFriendState.initial() = _Initial;
  const factory AddFriendState.loading() = _Loading;
  const factory AddFriendState.loaded() = _Loaded;
  const factory AddFriendState.error({required String error}) = _Error;
}
