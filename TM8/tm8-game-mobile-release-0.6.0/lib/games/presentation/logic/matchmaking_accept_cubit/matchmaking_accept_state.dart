part of 'matchmaking_accept_cubit.dart';

@freezed
class MatchmakingAcceptState with _$MatchmakingAcceptState {
  const factory MatchmakingAcceptState.initial() = _Initial;
  const factory MatchmakingAcceptState.loading() = _Loading;
  const factory MatchmakingAcceptState.loaded({
    required AcceptPotentialMatchResponse match,
    required int index,
    required String id,
  }) = _Loaded;
  const factory MatchmakingAcceptState.error({required String error}) = _Error;
}
