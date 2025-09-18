part of 'game_time_set_cubit.dart';

@freezed
class GameTimeSetState with _$GameTimeSetState {
  const factory GameTimeSetState.initial() = _Initial;
  const factory GameTimeSetState.loading() = _Loading;
  const factory GameTimeSetState.loaded() = _Loaded;
  const factory GameTimeSetState.error({required String error}) = _Error;
}
