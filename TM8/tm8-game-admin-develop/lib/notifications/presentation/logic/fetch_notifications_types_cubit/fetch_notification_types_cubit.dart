import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'fetch_notification_types_state.dart';
part 'fetch_notification_types_cubit.freezed.dart';

@injectable
class FetchNotificationTypesCubit extends Cubit<FetchNotificationTypesState> {
  FetchNotificationTypesCubit()
      : super(const FetchNotificationTypesState.initial());

  Future<void> fetchNotificationTypes() async {
    try {
      emit(const FetchNotificationTypesState.loading());
      final result = await api.apiV1ScheduledNotificationsTypesGet();

      if (result.isSuccessful) {
        emit(
          FetchNotificationTypesState.loaded(
            notificationTypes: result.bodyOrThrow,
            validationFailure: false,
          ),
        );
      } else {
        emit(FetchNotificationTypesState.error(error: result.error.toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const FetchNotificationTypesState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }

  void reEmitted(bool value) {
    var notificationTypes = state.whenOrNull(
      loaded: (notificationTypes, validationFailure) => notificationTypes,
    );
    emit(
      FetchNotificationTypesState.loaded(
        notificationTypes: notificationTypes ?? [],
        validationFailure: value,
      ),
    );
  }
}
