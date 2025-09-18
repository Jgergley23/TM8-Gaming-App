part of 'matchmaking_online_schedule_cubit.dart';

@freezed
class MatchmakingOnlineScheduleState with _$MatchmakingOnlineScheduleState {
  const factory MatchmakingOnlineScheduleState.initial() = _Initial;
  const factory MatchmakingOnlineScheduleState.loading() = _Loading;
  const factory MatchmakingOnlineScheduleState.loaded() = _Loaded;
  const factory MatchmakingOnlineScheduleState.error({required String error}) =
      _Error;
}
