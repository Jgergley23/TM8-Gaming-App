import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'edit_notification_state.dart';
part 'edit_notification_cubit.freezed.dart';

@injectable
class EditNotificationCubit extends Cubit<EditNotificationState> {
  EditNotificationCubit() : super(const EditNotificationState.initial());

  Future<void> editNotification({
    required UpdateScheduledNotificationInput body,
    required String notificationId,
  }) async {
    try {
      emit(const EditNotificationState.loading());
      final result = await api.apiV1ScheduledNotificationsNotificationIdPatch(
        body: body,
        notificationId: notificationId,
      );

      if (result.isSuccessful) {
        emit(
          EditNotificationState.loaded(
            editedNotification: result.bodyOrThrow,
          ),
        );
      } else {
        emit(
          EditNotificationState.error(
            error: result.handleError,
          ),
        );
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const EditNotificationState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }
}
