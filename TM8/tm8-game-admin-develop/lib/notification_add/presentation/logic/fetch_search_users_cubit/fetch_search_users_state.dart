part of 'fetch_search_users_cubit.dart';

@freezed
class FetchSearchUsersState with _$FetchSearchUsersState {
  const factory FetchSearchUsersState.initial() = _Initial;
  const factory FetchSearchUsersState.loading() = _Loading;
  const factory FetchSearchUsersState.loaded({
    required List<UserResponse> users,
  }) = _Loaded;
  const factory FetchSearchUsersState.error({required String error}) = _Error;
}
