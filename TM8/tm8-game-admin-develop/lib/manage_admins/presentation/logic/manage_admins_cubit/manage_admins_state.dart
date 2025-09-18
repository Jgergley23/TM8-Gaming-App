part of 'manage_admins_cubit.dart';

@freezed
class ManageAdminsState with _$ManageAdminsState {
  const factory ManageAdminsState.initial() = _Initial;
  const factory ManageAdminsState.loading({required int length}) = _Loading;
  const factory ManageAdminsState.loaded({
    required UserPaginatedResponse adminsResponse,
    required String? message,
    required AdminsTableDataFilters filters,
  }) = _Loaded;
  const factory ManageAdminsState.error({required String error}) = _Error;
}
