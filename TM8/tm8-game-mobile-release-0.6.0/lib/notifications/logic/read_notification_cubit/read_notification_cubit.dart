import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/notifications/logic/notification_unread_count_cubit/notification_unread_count_cubit.dart';

part 'read_notification_state.dart';
part 'read_notification_cubit.freezed.dart';

@injectable
class ReadNotificationCubit extends Cubit<ReadNotificationState> {
  ReadNotificationCubit() : super(const ReadNotificationState.initial());

  Future<void> readNotification({
    required String notificationId,
  }) async {
    try {
      emit(const ReadNotificationState.loading());

      await api.apiV1NotificationsNotificationIdReadPatch(
        notificationId: notificationId,
      );

      emit(
        const ReadNotificationState.loaded(),
      );
      sl<NotificationUnreadCountCubit>().fetchNotificationUnreadCount();
    } catch (e) {
      logError(e.toString());
      emit(
        ReadNotificationState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
