import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'matchmaking_online_schedule_state.dart';
part 'matchmaking_online_schedule_cubit.freezed.dart';

@injectable
class MatchmakingOnlineScheduleCubit
    extends Cubit<MatchmakingOnlineScheduleState> {
  MatchmakingOnlineScheduleCubit()
      : super(const MatchmakingOnlineScheduleState.initial());

  Future<void> onlineSchedule({
    required String game,
    required SetOnlineScheduleInput body, 
  }) async {
    try {
      emit(const MatchmakingOnlineScheduleState.loading());

      await api.apiV1UsersPreferencesGameOnlineSchedulePatch(
        game: game,
        body: body,
      );

      emit(
        const MatchmakingOnlineScheduleState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        MatchmakingOnlineScheduleState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
