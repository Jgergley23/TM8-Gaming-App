import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'fetch_notification_details_state.dart';
part 'fetch_notification_details_cubit.freezed.dart';

@injectable
class FetchNotificationDetailsCubit
    extends Cubit<FetchNotificationDetailsState> {
  FetchNotificationDetailsCubit()
      : super(const FetchNotificationDetailsState.initial());

  Future<void> fetchNotificationsData({
    required String notificationId,
  }) async {
    try {
      emit(const FetchNotificationDetailsState.loading());
      final result = await api.apiV1ScheduledNotificationsNotificationIdGet(
        notificationId: notificationId,
      );

      if (result.isSuccessful) {
        emit(
          FetchNotificationDetailsState.loaded(
            notificationDetails: result.bodyOrThrow,
          ),
        );
      } else {
        emit(
          FetchNotificationDetailsState.error(
            error: result.handleError,
          ),
        );
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const FetchNotificationDetailsState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }
}
