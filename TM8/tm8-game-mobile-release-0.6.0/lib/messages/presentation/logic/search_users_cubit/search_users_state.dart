part of 'search_users_cubit.dart';

@freezed
class SearchUsersState with _$SearchUsersState {
  const factory SearchUsersState.initial() = _Initial;
  const factory SearchUsersState.loading() = _Loading;
  const factory SearchUsersState.loaded({
    required List<UserSearchResponse> response,
  }) = _Loaded;
  const factory SearchUsersState.error({required String error}) = _Error;
}
