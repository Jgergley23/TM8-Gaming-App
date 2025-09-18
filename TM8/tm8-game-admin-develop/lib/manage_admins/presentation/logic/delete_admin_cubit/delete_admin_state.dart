part of 'delete_admin_cubit.dart';

@freezed
class DeleteAdminState with _$DeleteAdminState {
  const factory DeleteAdminState.initial() = _Initial;
  const factory DeleteAdminState.loading() = _Loading;
  const factory DeleteAdminState.loaded() = _Loaded;
  const factory DeleteAdminState.error({required String error}) = _Error;
}
