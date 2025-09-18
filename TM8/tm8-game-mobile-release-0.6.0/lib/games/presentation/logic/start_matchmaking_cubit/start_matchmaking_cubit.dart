import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';

part 'start_matchmaking_state.dart';
part 'start_matchmaking_cubit.freezed.dart';

@singleton
class StartMatchmakingCubit extends Cubit<StartMatchmakingState> {
  StartMatchmakingCubit() : super(const StartMatchmakingState.initial());

  Future<void> matchmakingAlgoritham({required String game}) async {
    try {
      emit(const StartMatchmakingState.loading());

      await api.apiV1MatchmakingGamePost(
        game: game,
      );

      emit(
        const StartMatchmakingState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        StartMatchmakingState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
