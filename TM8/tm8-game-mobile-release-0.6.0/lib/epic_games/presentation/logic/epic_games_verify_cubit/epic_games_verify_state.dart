part of 'epic_games_verify_cubit.dart';

@freezed
class EpicGamesVerifyState with _$EpicGamesVerifyState {
  const factory EpicGamesVerifyState.initial() = _Initial;
  const factory EpicGamesVerifyState.loading() = _Loading;
  const factory EpicGamesVerifyState.loaded() = _Loaded;
  const factory EpicGamesVerifyState.error({required String error}) = _Error;
}
