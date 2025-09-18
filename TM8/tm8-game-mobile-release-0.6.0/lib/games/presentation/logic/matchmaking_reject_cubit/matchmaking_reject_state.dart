part of 'matchmaking_reject_cubit.dart';

@freezed
class MatchmakingRejectState with _$MatchmakingRejectState {
  const factory MatchmakingRejectState.initial() = _Initial;
  const factory MatchmakingRejectState.loading() = _Loading;
  const factory MatchmakingRejectState.loaded() = _Loaded;
  const factory MatchmakingRejectState.error({required String error}) = _Error;
}
