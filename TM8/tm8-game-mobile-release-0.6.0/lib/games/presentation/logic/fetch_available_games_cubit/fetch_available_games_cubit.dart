import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_available_games_state.dart';
part 'fetch_available_games_cubit.freezed.dart';

@injectable
class FetchAvailableGamesCubit extends Cubit<FetchAvailableGamesState> {
  FetchAvailableGamesCubit() : super(const FetchAvailableGamesState.initial());

  Future<void> fetchAvailableGames({
    required List<String> alreadyAddedGames,
  }) async {
    try {
      emit(const FetchAvailableGamesState.loading());

      final result = await api.apiV1GamesGet();

      final res = result.bodyOrThrow;
      final indexesToRemove = <int>[];
      for (final item in res) {
        if (alreadyAddedGames.contains(item.game.value)) {
          indexesToRemove.add(res.indexOf(item));
        }
      }
      // done because in flutter index out of range errors are thrown otherwise
      indexesToRemove.sort((a, b) => b.compareTo(a));
      for (var index in indexesToRemove) {
        if (index >= 0 && index < res.length) {
          res.removeAt(index);
        }
      }
      emit(
        FetchAvailableGamesState.loaded(games: res),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        FetchAvailableGamesState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
