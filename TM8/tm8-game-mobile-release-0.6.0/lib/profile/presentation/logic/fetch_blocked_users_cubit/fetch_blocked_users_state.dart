part of 'fetch_blocked_users_cubit.dart';

@freezed
class FetchBlockedUsersState with _$FetchBlockedUsersState {
  const factory FetchBlockedUsersState.initial() = _Initial;
  const factory FetchBlockedUsersState.loading() = _Loading;
  const factory FetchBlockedUsersState.loaded({
    required UserPaginatedResponse blockedUsers,
    required bool fakeDelete,
    required List<String> ids,
  }) = _Loaded;
  const factory FetchBlockedUsersState.error({required String error}) = _Error;
}
