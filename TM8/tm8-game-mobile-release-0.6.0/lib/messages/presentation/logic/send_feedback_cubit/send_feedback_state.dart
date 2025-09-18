part of 'send_feedback_cubit.dart';

@freezed
class SendFeedbackState with _$SendFeedbackState {
  const factory SendFeedbackState.initial() = _Initial;
  const factory SendFeedbackState.loading() = _Loading;
  const factory SendFeedbackState.loaded() = _Loaded;
  const factory SendFeedbackState.error({required String error}) = _Error;
}
