import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/notifications/logic/notification_unread_count_cubit/notification_unread_count_cubit.dart';

part 'delete_notification_state.dart';
part 'delete_notification_cubit.freezed.dart';

@injectable
class DeleteNotificationCubit extends Cubit<DeleteNotificationState> {
  DeleteNotificationCubit() : super(const DeleteNotificationState.initial());

  Future<void> deleteNotification({required String notificationId}) async {
    try {
      emit(const DeleteNotificationState.loading());

      await api.apiV1NotificationsNotificationIdDelete(
        notificationId: notificationId,
      );

      emit(
        const DeleteNotificationState.loaded(),
      );
      sl<NotificationUnreadCountCubit>().fetchNotificationUnreadCount();
    } catch (e) {
      logError(e.toString());
      emit(
        DeleteNotificationState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
