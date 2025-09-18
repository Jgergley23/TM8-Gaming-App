part of 'fetch_random_matchmaking_cubit.dart';

@freezed
class FetchRandomMatchmakingState with _$FetchRandomMatchmakingState {
  const factory FetchRandomMatchmakingState.initial() = _Initial;
  const factory FetchRandomMatchmakingState.loading() = _Loading;
  const factory FetchRandomMatchmakingState.loaded({
    required MatchmakingResultPaginatedResponse matches,
  }) = _Loaded;
  const factory FetchRandomMatchmakingState.error({required String error}) =
      _Error;
}
