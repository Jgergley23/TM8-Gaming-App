import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';

part 'delete_notification_state.dart';
part 'delete_notification_cubit.freezed.dart';

@injectable
class DeleteNotificationCubit extends Cubit<DeleteNotificationState> {
  DeleteNotificationCubit() : super(const DeleteNotificationState.initial());

  Future<void> deleteNotification({
    required DeleteScheduledNotificationsInput notificationsInput,
  }) async {
    try {
      emit(const DeleteNotificationState.loading());
      final result = await api.apiV1ScheduledNotificationsDelete(
        body: notificationsInput,
      );

      if (result.isSuccessful) {
        emit(
          DeleteNotificationState.loaded(
            notificationId: notificationsInput.notificationIds.first,
          ),
        );
      } else {
        emit(DeleteNotificationState.error(error: result.handleError));
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const DeleteNotificationState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }
}
