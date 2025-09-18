part of 'epic_games_first_run_check_cubit.dart';

@freezed
class EpicGamesFirstRunCheckState with _$EpicGamesFirstRunCheckState {
  const factory EpicGamesFirstRunCheckState.initial() = _Initial;
  const factory EpicGamesFirstRunCheckState.execute() = _Execute;
  const factory EpicGamesFirstRunCheckState.skip() = _Skip;
}
