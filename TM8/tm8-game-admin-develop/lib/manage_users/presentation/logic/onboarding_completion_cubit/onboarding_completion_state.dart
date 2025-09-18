part of 'onboarding_completion_cubit.dart';

@freezed
class OnboardingCompletionState with _$OnboardingCompletionState {
  const factory OnboardingCompletionState.initial() = _Initial;
  const factory OnboardingCompletionState.loading() = _Loading;
  const factory OnboardingCompletionState.loaded({
    required StatisticsOnboardingCompletionResponse
        statisticsOnboardingCompletionResponse,
  }) = _Loaded;
  const factory OnboardingCompletionState.error({required String error}) =
      _Error;
}
