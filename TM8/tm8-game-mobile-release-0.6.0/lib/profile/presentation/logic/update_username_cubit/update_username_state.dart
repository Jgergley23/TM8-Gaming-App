part of 'update_username_cubit.dart';

@freezed
class UpdateUsernameState with _$UpdateUsernameState {
  const factory UpdateUsernameState.initial() = _Initial;
  const factory UpdateUsernameState.loading() = _Loading;
  const factory UpdateUsernameState.loaded() = _Loaded;
  const factory UpdateUsernameState.error({required String error}) = _Error;
}
