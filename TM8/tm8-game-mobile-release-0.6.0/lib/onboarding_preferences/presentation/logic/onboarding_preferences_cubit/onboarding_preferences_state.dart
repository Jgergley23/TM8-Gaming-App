part of 'onboarding_preferences_cubit.dart';

@freezed
class OnboardingPreferencesState with _$OnboardingPreferencesState {
  const factory OnboardingPreferencesState.initial() = _Initial;
  const factory OnboardingPreferencesState.loading() = _Loading;
  const factory OnboardingPreferencesState.loaded({
    required List<GamePreferenceInputResponse> inputResponse,
    required String game,
    required int index,
  }) = _Loaded;
  const factory OnboardingPreferencesState.error({
    required String error,
    required String game,
    required int index,
  }) = _Error;
}
