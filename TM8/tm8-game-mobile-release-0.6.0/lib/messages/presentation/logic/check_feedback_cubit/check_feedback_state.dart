part of 'check_feedback_cubit.dart';

@freezed
class CheckFeedbackState with _$CheckFeedbackState {
  const factory CheckFeedbackState.initial() = _Initial;
  const factory CheckFeedbackState.loading() = _Loading;
  const factory CheckFeedbackState.loaded({
    required CheckFeedbackGivenResponse feedbackCheck,
  }) = _Loaded;
  const factory CheckFeedbackState.error({required String error}) = _Error;
}
