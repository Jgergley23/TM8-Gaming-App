part of 'fetch_user_groups_cubit.dart';

@freezed
class FetchUserGroupsState with _$FetchUserGroupsState {
  const factory FetchUserGroupsState.initial() = _Initial;
  const factory FetchUserGroupsState.loading() = _Loading;
  const factory FetchUserGroupsState.loaded({
    required List<UserGroupResponseAddedCount> userGroups,
    required bool failedValidation,
  }) = _Loaded;
  const factory FetchUserGroupsState.error({required String error}) = _Error;
}
