part of 'added_games_cubit.dart';

@freezed
class AddedGamesState with _$AddedGamesState {
  const factory AddedGamesState.initial() = _Initial;
  const factory AddedGamesState.loading() = _Loading;
  const factory AddedGamesState.loaded({
    required List<UserGameDataResponse> userGameDataResponse,
  }) = _Loaded;
  const factory AddedGamesState.error({
    required String error,
  }) = _Error;
}
