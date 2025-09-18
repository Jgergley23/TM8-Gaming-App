part of 'delete_my_account_cubit.dart';

@freezed
class DeleteMyAccountState with _$DeleteMyAccountState {
  const factory DeleteMyAccountState.initial() = _Initial;
  const factory DeleteMyAccountState.loading() = _Loading;
  const factory DeleteMyAccountState.loaded() = _Loaded;
  const factory DeleteMyAccountState.error({required String error}) = _Error;
}
