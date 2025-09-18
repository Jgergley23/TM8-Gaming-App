part of 'block_user_cubit.dart';

@freezed
class BlockUserState with _$BlockUserState {
  const factory BlockUserState.initial() = _Initial;
  const factory BlockUserState.loading() = _Loading;
  const factory BlockUserState.loaded() = _Loaded;
  const factory BlockUserState.error({required String error}) = _Error;
}
