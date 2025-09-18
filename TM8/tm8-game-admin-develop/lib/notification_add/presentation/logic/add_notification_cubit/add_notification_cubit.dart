import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'add_notification_state.dart';
part 'add_notification_cubit.freezed.dart';

@injectable
class AddNotificationCubit extends Cubit<AddNotificationState> {
  AddNotificationCubit() : super(const AddNotificationState.initial());

  Future<void> addNotification({
    required CreateScheduledNotificationInput notificationInput,
  }) async {
    try {
      emit(const AddNotificationState.loading());
      final result =
          await api.apiV1ScheduledNotificationsPost(body: notificationInput);

      if (result.isSuccessful) {
        emit(
          AddNotificationState.loaded(
            addedNotification: result.bodyOrThrow,
          ),
        );
      } else {
        emit(
          AddNotificationState.error(
            error: result.handleError,
          ),
        );
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const AddNotificationState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }
}
