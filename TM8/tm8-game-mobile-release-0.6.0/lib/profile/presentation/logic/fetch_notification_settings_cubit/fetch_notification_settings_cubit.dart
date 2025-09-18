import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_notification_settings_state.dart';
part 'fetch_notification_settings_cubit.freezed.dart';

@injectable
class FetchNotificationSettingsCubit
    extends Cubit<FetchNotificationSettingsState> {
  FetchNotificationSettingsCubit()
      : super(const FetchNotificationSettingsState.initial());

  Future<void> fetchNotificationSettings() async {
    try {
      emit(const FetchNotificationSettingsState.loading());

      final result = await api.apiV1NotificationsSettingsOptionsGet();

      emit(
        FetchNotificationSettingsState.loaded(
          notificationSettings: result.bodyOrThrow,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        FetchNotificationSettingsState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
