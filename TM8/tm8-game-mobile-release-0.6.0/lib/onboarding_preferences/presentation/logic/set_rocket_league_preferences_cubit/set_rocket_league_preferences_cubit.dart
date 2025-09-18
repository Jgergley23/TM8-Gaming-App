import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'set_rocket_league_preferences_state.dart';
part 'set_rocket_league_preferences_cubit.freezed.dart';

@injectable
class SetRocketLeaguePreferencesCubit
    extends Cubit<SetRocketLeaguePreferencesState> {
  SetRocketLeaguePreferencesCubit()
      : super(const SetRocketLeaguePreferencesState.initial());

  Future<void> setRocketLeaguePreferences({
    required Map<String, dynamic> map,
    required int index,
    required String game,
    required bool added,
  }) async {
    try {
      emit(const SetRocketLeaguePreferencesState.loading());

      var body = const SetRocketLeaguePreferencesInput(
        playingLevel: '',
        gameModes: [],
        gameplays: [],
        playStyle: '',
        teamSizes: [],
      );

      map[game].forEach((key, value) {
        if (key == 'Game Mode') {
          body = body.copyWith(gameModes: value);
        } else if (key == 'Play Style') {
          body = body.copyWith(playStyle: value);
        } else if (key == 'Team Size') {
          body = body.copyWith(teamSizes: value);
        } else if (key == 'Playing Level') {
          body = body.copyWith(playingLevel: value);
        } else if (key == 'Gameplay') {
          body = body.copyWith(gameplays: value);
        }
      });
      if (!added) {
        await api.apiV1UsersUserIdGameGamePost(
          userId: sl<Tm8Storage>().userId,
          game: game,
        );
      }

      final result = await api.apiV1UsersPreferencesRocketLeaguePatch(
        body: body,
      );

      emit(
        SetRocketLeaguePreferencesState.loaded(
          gameDateResponse: result.bodyOrThrow,
          index: index,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        SetRocketLeaguePreferencesState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
