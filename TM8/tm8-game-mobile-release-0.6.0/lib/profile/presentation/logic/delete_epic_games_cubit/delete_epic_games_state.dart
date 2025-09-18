part of 'delete_epic_games_cubit.dart';

@freezed
class DeleteEpicGamesState with _$DeleteEpicGamesState {
  const factory DeleteEpicGamesState.initial() = _Initial;
  const factory DeleteEpicGamesState.loading() = _Loading;
  const factory DeleteEpicGamesState.loaded() = _Loaded;
  const factory DeleteEpicGamesState.error({required String error}) = _Error;
}
