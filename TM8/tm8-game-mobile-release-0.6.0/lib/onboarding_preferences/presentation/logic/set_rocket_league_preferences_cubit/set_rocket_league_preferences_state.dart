part of 'set_rocket_league_preferences_cubit.dart';

@freezed
class SetRocketLeaguePreferencesState with _$SetRocketLeaguePreferencesState {
  const factory SetRocketLeaguePreferencesState.initial() = _Initial;
  const factory SetRocketLeaguePreferencesState.loading() = _Loading;
  const factory SetRocketLeaguePreferencesState.loaded({
    required UserGameDataResponse gameDateResponse,
    required int index,
  }) = _Loaded;
  const factory SetRocketLeaguePreferencesState.error({
    required String error,
  }) = _Error;
}
