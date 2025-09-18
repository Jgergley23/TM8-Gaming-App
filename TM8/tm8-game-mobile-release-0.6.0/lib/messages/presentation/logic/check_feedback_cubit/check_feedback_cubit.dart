import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'check_feedback_state.dart';
part 'check_feedback_cubit.freezed.dart';

@injectable
class CheckFeedbackCubit extends Cubit<CheckFeedbackState> {
  CheckFeedbackCubit() : super(const CheckFeedbackState.initial());

  Future<void> checkFeedback({required String userId}) async {
    try {
      emit(const CheckFeedbackState.loading());

      final result = await api.apiV1MatchesFeedbackUsersUserIdCheckGet(
        userId: userId,
      );

      emit(
        CheckFeedbackState.loaded(feedbackCheck: result.bodyOrThrow),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        CheckFeedbackState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
