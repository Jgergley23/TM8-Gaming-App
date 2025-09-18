part of 'matchmaking_schedule_remove_cubit.dart';

@freezed
class MatchmakingScheduleRemoveState with _$MatchmakingScheduleRemoveState {
  const factory MatchmakingScheduleRemoveState.initial() = _Initial;
  const factory MatchmakingScheduleRemoveState.loading() = _Loading;
  const factory MatchmakingScheduleRemoveState.loaded({
    required bool refetch,
  }) = _Loaded;
  const factory MatchmakingScheduleRemoveState.error({required String error}) =
      _Error;
}
