part of 'unblock_user_cubit.dart';

@freezed
class UnblockUserState with _$UnblockUserState {
  const factory UnblockUserState.initial() = _Initial;
  const factory UnblockUserState.loading() = _Loading;
  const factory UnblockUserState.loaded() = _Loaded;
  const factory UnblockUserState.error({required String error}) = _Error;
}
