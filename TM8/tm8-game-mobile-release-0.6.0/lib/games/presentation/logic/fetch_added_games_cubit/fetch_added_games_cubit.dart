import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_added_games_state.dart';
part 'fetch_added_games_cubit.freezed.dart';

@injectable
class FetchAddedGamesCubit extends Cubit<FetchAddedGamesState> {
  FetchAddedGamesCubit() : super(const FetchAddedGamesState.initial());

  Future<void> fetchAddedGames() async {
    try {
      emit(const FetchAddedGamesState.loading());

      var userId = sl<Tm8Storage>().userId;
      if (userId == '' || userId.isEmpty) {
        final result = await api.apiV1UsersMeGet();
        if (result.bodyOrThrow.id != '') {
          userId = result.body?.id ?? '';
        }
      }

      final result = await api.apiV1UsersUserIdPreferencesGet(
        userId: userId,
      );

      emit(
        FetchAddedGamesState.loaded(games: result.bodyOrThrow),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        FetchAddedGamesState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
