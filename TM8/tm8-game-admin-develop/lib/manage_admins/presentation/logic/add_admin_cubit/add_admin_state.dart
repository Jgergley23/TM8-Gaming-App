part of 'add_admin_cubit.dart';

@freezed
class AddAdminState with _$AddAdminState {
  const factory AddAdminState.initial() = _Initial;
  const factory AddAdminState.loading() = _Loading;
  const factory AddAdminState.loaded() = _Loaded;
  const factory AddAdminState.error({required String error}) = _Error;
}
