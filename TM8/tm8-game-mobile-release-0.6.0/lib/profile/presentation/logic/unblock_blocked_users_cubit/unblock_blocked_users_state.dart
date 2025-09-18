part of 'unblock_blocked_users_cubit.dart';

@freezed
class UnblockBlockedUsersState with _$UnblockBlockedUsersState {
  const factory UnblockBlockedUsersState.initial() = _Initial;
  const factory UnblockBlockedUsersState.loading() = _Loading;
  const factory UnblockBlockedUsersState.loaded() = _Loaded;
  const factory UnblockBlockedUsersState.error({required String error}) =
      _Error;
}
