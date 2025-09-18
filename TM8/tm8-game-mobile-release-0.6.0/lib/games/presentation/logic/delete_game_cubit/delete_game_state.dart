part of 'delete_game_cubit.dart';

@freezed
class DeleteGameState with _$DeleteGameState {
  const factory DeleteGameState.initial() = _Initial;
  const factory DeleteGameState.loading() = _Loading;
  const factory DeleteGameState.loaded() = _Loaded;
  const factory DeleteGameState.error({required String error}) = _Error;
}
