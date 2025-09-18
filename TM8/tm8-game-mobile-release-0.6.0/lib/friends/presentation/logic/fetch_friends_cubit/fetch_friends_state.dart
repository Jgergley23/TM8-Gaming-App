part of 'fetch_friends_cubit.dart';

@freezed
class FetchFriendsState with _$FetchFriendsState {
  const factory FetchFriendsState.initial() = _Initial;
  const factory FetchFriendsState.loading({
    required List<UserResponse> friendList,
  }) = _Loading;
  const factory FetchFriendsState.loaded({
    required UserPaginatedResponse friendList,
    required String? username,
  }) = _Loaded;
  const factory FetchFriendsState.error({required String error}) = _Error;
}
