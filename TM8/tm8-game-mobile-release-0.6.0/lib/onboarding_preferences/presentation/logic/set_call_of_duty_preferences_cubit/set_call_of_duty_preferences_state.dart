part of 'set_call_of_duty_preferences_cubit.dart';

@freezed
class SetCallOfDutyPreferencesState with _$SetCallOfDutyPreferencesState {
  const factory SetCallOfDutyPreferencesState.initial() = _Initial;
  const factory SetCallOfDutyPreferencesState.loading() = _Loading;
  const factory SetCallOfDutyPreferencesState.loaded({
    required UserGameDataResponse gameDateResponse,
    required int index,
  }) = _Loaded;
  const factory SetCallOfDutyPreferencesState.error({
    required String error,
  }) = _Error;
}
