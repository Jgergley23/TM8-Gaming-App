part of 'set_fortnite_preferences_cubit.dart';

@freezed
class SetFortnitePreferencesState with _$SetFortnitePreferencesState {
  const factory SetFortnitePreferencesState.initial() = _Initial;
  const factory SetFortnitePreferencesState.loading() = _Loading;
  const factory SetFortnitePreferencesState.loaded({
    required UserGameDataResponse gameDateResponse,
    required int index,
  }) = _Loaded;
  const factory SetFortnitePreferencesState.error({
    required String error,
  }) = _Error;
}
