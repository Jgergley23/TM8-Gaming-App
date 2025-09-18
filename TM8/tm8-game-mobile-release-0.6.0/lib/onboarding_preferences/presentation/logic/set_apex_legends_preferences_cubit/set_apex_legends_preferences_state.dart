part of 'set_apex_legends_preferences_cubit.dart';

@freezed
class SetApexLegendsPreferencesState with _$SetApexLegendsPreferencesState {
  const factory SetApexLegendsPreferencesState.initial() = _Initial;
  const factory SetApexLegendsPreferencesState.loading() = _Loading;
  const factory SetApexLegendsPreferencesState.loaded({
    required UserGameDataResponse gameDateResponse,
    required int index,
  }) = _Loaded;
  const factory SetApexLegendsPreferencesState.error({
    required String error,
  }) = _Error;
}
