import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'set_apex_legends_preferences_state.dart';
part 'set_apex_legends_preferences_cubit.freezed.dart';

@injectable
class SetApexLegendsPreferencesCubit
    extends Cubit<SetApexLegendsPreferencesState> {
  SetApexLegendsPreferencesCubit()
      : super(const SetApexLegendsPreferencesState.initial());

  Future<void> setApexLegendsPreferences({
    required Map<String, dynamic> map,
    required int index,
    required String game,
    required bool added,
  }) async {
    try {
      emit(const SetApexLegendsPreferencesState.loading());

      var body = const SetApexLegendsPreferencesInput(
        playingLevel: '',
        agression: 3,
        teamWork: 3,
        gameplayStyle: 3,
        classifications: [],
        rotations: [],
        teamSizes: [],
        types: [],
        mixtapeTypes: [],
      );

      map[game].forEach((key, value) {
        if (key == 'Team Size') {
          body = body.copyWith(teamSizes: value);
        } else if (key == 'Playing Level') {
          body = body.copyWith(playingLevel: value);
        } else if (key == 'Type') {
          body = body.copyWith(types: value);
        } else if (key == 'Mixtape Type') {
          body = body.copyWith(mixtapeTypes: value);
        } else if (key == 'Classifications') {
          body = body.copyWith(classifications: value);
        } else if (key == 'Rotate') {
          body = body.copyWith(rotations: value);
        } else if (key == 'aggressive') {
          body = body.copyWith(agression: value);
        } else if (key == 'team-player') {
          body = body.copyWith(teamWork: value);
        } else if (key == 'find-people') {
          body = body.copyWith(gameplayStyle: value);
        }
      });
      if (!added) {
        await api.apiV1UsersUserIdGameGamePost(
          userId: sl<Tm8Storage>().userId,
          game: game,
        );
      }

      final result = await api.apiV1UsersPreferencesApexLegendsPatch(
        body: body,
      );

      emit(
        SetApexLegendsPreferencesState.loaded(
          gameDateResponse: result.bodyOrThrow,
          index: index,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        SetApexLegendsPreferencesState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
