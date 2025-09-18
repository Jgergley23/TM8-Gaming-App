import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'game_time_set_state.dart';
part 'game_time_set_cubit.freezed.dart';

@injectable
class GameTimeSetCubit extends Cubit<GameTimeSetState> {
  GameTimeSetCubit() : super(const GameTimeSetState.initial());

  Future<void> setGameTime({
    required String game,
    required SetGamePlaytimeInput body,
  }) async {
    try {
      emit(const GameTimeSetState.loading());

      await api.apiV1UsersPreferencesGamePlaytimePatch(
        game: game,
        body: body,
      );

      emit(
        const GameTimeSetState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        GameTimeSetState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
