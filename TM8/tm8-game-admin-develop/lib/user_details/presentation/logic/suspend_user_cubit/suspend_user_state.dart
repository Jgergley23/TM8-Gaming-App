part of 'suspend_user_cubit.dart';

@freezed
class SuspendUserState with _$SuspendUserState {
  const factory SuspendUserState.initial() = _Initial;
  const factory SuspendUserState.loading() = _Loading;
  const factory SuspendUserState.loaded({
    required List<UserResponse> userSuspended,
  }) = _Loaded;
  const factory SuspendUserState.error({
    required String error,
  }) = _Error;
}
