part of 'manage_users_cubit.dart';

@freezed
class ManageUsersState with _$ManageUsersState {
  const factory ManageUsersState.initial() = _Initial;
  const factory ManageUsersState.loading({required int length}) = _Loading;
  const factory ManageUsersState.loaded({
    required UserPaginatedResponse userPaginatedResponse,
    String? message,
    required UsersTableDataFilters filters,
  }) = _Loaded;
  const factory ManageUsersState.error({required String error}) = _Error;
}
