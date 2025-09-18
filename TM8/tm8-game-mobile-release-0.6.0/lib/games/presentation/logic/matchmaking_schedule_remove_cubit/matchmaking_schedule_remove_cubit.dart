import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';

part 'matchmaking_schedule_remove_state.dart';
part 'matchmaking_schedule_remove_cubit.freezed.dart';

@injectable
class MatchmakingScheduleRemoveCubit
    extends Cubit<MatchmakingScheduleRemoveState> {
  MatchmakingScheduleRemoveCubit()
      : super(const MatchmakingScheduleRemoveState.initial());

  Future<void> removeOnlineSchedule({
    required String game,
    required bool refetch,
  }) async {
    try {
      emit(const MatchmakingScheduleRemoveState.loading());

      await api.apiV1UsersPreferencesGameOnlineScheduleDelete(
        game: game,
      );

      emit(
        MatchmakingScheduleRemoveState.loaded(refetch: refetch),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        MatchmakingScheduleRemoveState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
