part of 'fetch_added_games_cubit.dart';

@freezed
class FetchAddedGamesState with _$FetchAddedGamesState {
  const factory FetchAddedGamesState.initial() = _Initial;
  const factory FetchAddedGamesState.loading() = _Loading;
  const factory FetchAddedGamesState.loaded({
    required List<UserGameDataResponse> games,
  }) = _Loaded;
  const factory FetchAddedGamesState.error({required String error}) = _Error;
}
