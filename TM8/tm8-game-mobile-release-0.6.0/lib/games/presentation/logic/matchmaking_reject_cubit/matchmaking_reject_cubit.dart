import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'matchmaking_reject_state.dart';
part 'matchmaking_reject_cubit.freezed.dart';

@injectable
class MatchmakingRejectCubit extends Cubit<MatchmakingRejectState> {
  MatchmakingRejectCubit() : super(const MatchmakingRejectState.initial());

  Future<void> matchmakingReject({
    required String game,
    required GetUserByIdParams body,
  }) async {
    try {
      emit(const MatchmakingRejectState.loading());

      await api.apiV1MatchmakingGameRejectPost(
        game: game,
        body: body,
      );

      emit(
        const MatchmakingRejectState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        MatchmakingRejectState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
