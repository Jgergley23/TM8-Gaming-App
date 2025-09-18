import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'notification_unread_count_state.dart';
part 'notification_unread_count_cubit.freezed.dart';

@singleton
class NotificationUnreadCountCubit extends Cubit<NotificationUnreadCountState> {
  NotificationUnreadCountCubit()
      : super(const NotificationUnreadCountState.initial());

  Future<void> fetchNotificationUnreadCount() async {
    try {
      emit(const NotificationUnreadCountState.loading());

      final result = await api.apiV1NotificationsUnreadCountGet();

      emit(
        NotificationUnreadCountState.loaded(
          notificationCount: result.bodyOrThrow,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        NotificationUnreadCountState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
