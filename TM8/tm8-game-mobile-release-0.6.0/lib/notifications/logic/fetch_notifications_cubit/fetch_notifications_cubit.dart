import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_notifications_state.dart';
part 'fetch_notifications_cubit.freezed.dart';

@singleton
class FetchNotificationsCubit extends Cubit<FetchNotificationsState> {
  FetchNotificationsCubit() : super(const FetchNotificationsState.initial());

  Future<void> fetchNotifications() async {
    try {
      emit(const FetchNotificationsState.loading(notificationList: []));

      final result = await api.apiV1NotificationsGet(page: 1, limit: 15);

      emit(
        FetchNotificationsState.loaded(notification: result.bodyOrThrow),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        FetchNotificationsState.error(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchNextPage({
    required int page,
    required List<NotificationResponse> notificationList,
  }) async {
    try {
      emit(FetchNotificationsState.loading(notificationList: notificationList));

      final result = await api.apiV1NotificationsGet(page: page, limit: 15);

      emit(
        FetchNotificationsState.loaded(
          notification: NotificationPaginatedResponse(
            items: notificationList + result.bodyOrThrow.items,
            meta: result.bodyOrThrow.meta,
          ),
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        FetchNotificationsState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
