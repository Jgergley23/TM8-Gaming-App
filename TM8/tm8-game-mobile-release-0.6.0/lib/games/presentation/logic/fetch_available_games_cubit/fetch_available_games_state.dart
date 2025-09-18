part of 'fetch_available_games_cubit.dart';

@freezed
class FetchAvailableGamesState with _$FetchAvailableGamesState {
  const factory FetchAvailableGamesState.initial() = _Initial;
  const factory FetchAvailableGamesState.loading() = _Loading;
  const factory FetchAvailableGamesState.loaded({
    required List<GameResponse> games,
  }) = _Loaded;
  const factory FetchAvailableGamesState.error({required String error}) =
      _Error;
}
