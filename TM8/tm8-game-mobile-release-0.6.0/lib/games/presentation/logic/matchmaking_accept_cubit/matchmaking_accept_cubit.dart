import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'matchmaking_accept_state.dart';
part 'matchmaking_accept_cubit.freezed.dart';

@injectable
class MatchmakingAcceptCubit extends Cubit<MatchmakingAcceptState> {
  MatchmakingAcceptCubit() : super(const MatchmakingAcceptState.initial());

  Future<void> matchmakingAccept({
    required String game,
    required GetUserByIdParams body,
    required int index,
  }) async {
    try {
      emit(const MatchmakingAcceptState.loading());

      final result = await api.apiV1MatchmakingGameAcceptPost(
        game: game,
        body: body,
      );

      emit(
        MatchmakingAcceptState.loaded(
          match: result.bodyOrThrow,
          index: index,
          id: body.userId,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        MatchmakingAcceptState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
