part of 'start_matchmaking_cubit.dart';

@freezed
class StartMatchmakingState with _$StartMatchmakingState {
  const factory StartMatchmakingState.initial() = _Initial;
  const factory StartMatchmakingState.loading() = _Loading;
  const factory StartMatchmakingState.loaded() = _Loaded;
  const factory StartMatchmakingState.error({required String error}) = _Error;
}
