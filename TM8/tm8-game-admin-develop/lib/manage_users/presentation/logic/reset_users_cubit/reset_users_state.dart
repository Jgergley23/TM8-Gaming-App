part of 'reset_users_cubit.dart';

@freezed
class ResetUserState with _$ResetUserState {
  const factory ResetUserState.initial() = _Initial;
  const factory ResetUserState.loading() = _Loading;
  const factory ResetUserState.loaded({
    required List<UserResponse> userResponse,
    required bool undo,
    required String note,
    required bool rowAction,
  }) = _Loaded;
  const factory ResetUserState.error({required String error}) = _Error;
}
