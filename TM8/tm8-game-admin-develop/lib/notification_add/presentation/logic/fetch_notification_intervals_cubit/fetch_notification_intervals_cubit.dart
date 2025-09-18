import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'fetch_notification_intervals_state.dart';
part 'fetch_notification_intervals_cubit.freezed.dart';

@injectable
class FetchNotificationIntervalsCubit
    extends Cubit<FetchNotificationIntervalsState> {
  FetchNotificationIntervalsCubit()
      : super(const FetchNotificationIntervalsState.initial());

  Future<void> fetchNotificationIntervals() async {
    try {
      emit(const FetchNotificationIntervalsState.loading());
      final result = await api.apiV1ScheduledNotificationsIntervalsGet();

      if (result.isSuccessful) {
        emit(
          FetchNotificationIntervalsState.loaded(
            intervals: result.bodyOrThrow,
          ),
        );
      } else {
        emit(
          FetchNotificationIntervalsState.error(
            error: result.handleError,
          ),
        );
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const FetchNotificationIntervalsState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }
}
