part of 'fetch_friends_games_cubit.dart';

@freezed
class FetchFriendsGamesState with _$FetchFriendsGamesState {
  const factory FetchFriendsGamesState.initial() = _Initial;
  const factory FetchFriendsGamesState.loading() = _Loading;
  const factory FetchFriendsGamesState.loaded({
    required UserGamesResponse userGames,
  }) = _Loaded;
  const factory FetchFriendsGamesState.error({required String error}) = _Error;
}
