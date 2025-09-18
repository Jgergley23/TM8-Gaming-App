import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';

part 'send_feedback_state.dart';
part 'send_feedback_cubit.freezed.dart';

@injectable
class SendFeedbackCubit extends Cubit<SendFeedbackState> {
  SendFeedbackCubit() : super(const SendFeedbackState.initial());

  Future<void> sendFeedback({
    required String matchId,
    required num rating,
  }) async {
    try {
      emit(const SendFeedbackState.loading());

      await api.apiV1MatchesMatchIdFeedbackRatingPost(
        matchId: matchId,
        rating: rating,
      );

      emit(
        const SendFeedbackState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        SendFeedbackState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
