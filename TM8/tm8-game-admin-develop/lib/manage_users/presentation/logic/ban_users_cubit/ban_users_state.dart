part of 'ban_users_cubit.dart';

@freezed
class BanUsersState with _$BanUsersState {
  const factory BanUsersState.initial() = _Initial;
  const factory BanUsersState.loading() = _Loading;
  const factory BanUsersState.loaded({
    required List<UserResponse> userResponse,
    required bool undo,
    required String note,
    required bool onRowAction,
  }) = _Loaded;
  const factory BanUsersState.error({required String error}) = _Error;
}
