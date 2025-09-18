import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'fetch_notifications_state.dart';
part 'fetch_notifications_cubit.freezed.dart';

@injectable
class FetchNotificationsCubit extends Cubit<FetchNotificationsState> {
  FetchNotificationsCubit() : super(const FetchNotificationsState.initial());

  Future<void> fetchNotificationsData({
    required NotificationTableDataFilters filters,
  }) async {
    try {
      String? message;
      emit(FetchNotificationsState.loading(length: filters.rowSize));
      final result = await api.apiV1ScheduledNotificationsGet(
        page: filters.page,
        limit: filters.rowSize,
        sort: filters.sort,
        title: filters.title,
        userGroups: filters.userGroups,
        types: filters.types,
      );

      if (result.isSuccessful) {
        if (filters.types != null && result.bodyOrThrow.items.isEmpty) {
          message = 'No results found';
        } else if (filters.userGroups != null &&
            result.bodyOrThrow.items.isEmpty) {
          message = 'No results found';
        } else if (filters.title != null && result.bodyOrThrow.items.isEmpty) {
          message = 'No results found';
        }
        emit(
          FetchNotificationsState.loaded(
            notificationPaginatedResponse: result.bodyOrThrow,
            filters: filters,
            message: message,
          ),
        );
      } else {
        emit(FetchNotificationsState.error(error: result.error.toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(const FetchNotificationsState.error(error: 'Something went wrong'));
    }
  }

  Future<void> emitLoading({
    required int rowSize,
  }) async {
    emit(FetchNotificationsState.loading(length: rowSize));
  }
}

class NotificationTableDataFilters {
  NotificationTableDataFilters({
    required this.page,
    required this.rowSize,
    this.sort,
    this.title,
    this.userGroups,
    this.types,
  });

  final int page;
  final int rowSize;
  String? sort;
  String? title;
  String? userGroups;
  String? types;
}
