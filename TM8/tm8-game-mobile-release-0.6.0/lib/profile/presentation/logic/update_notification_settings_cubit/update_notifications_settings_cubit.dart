import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'update_notifications_settings_state.dart';
part 'update_notifications_settings_cubit.freezed.dart';

@injectable
class UpdateNotificationsSettingsCubit
    extends Cubit<UpdateNotificationsSettingsState> {
  UpdateNotificationsSettingsCubit()
      : super(const UpdateNotificationsSettingsState.initial());

  Future<void> updateNotificationSettings({
    required UpdateNotificationSettingsDto body,
  }) async {
    try {
      emit(const UpdateNotificationsSettingsState.loading());

      await api.apiV1NotificationsSettingsPatch(body: body);

      emit(
        const UpdateNotificationsSettingsState.loaded(),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
    } catch (e) {
      logError(e.toString());
      emit(
        UpdateNotificationsSettingsState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
