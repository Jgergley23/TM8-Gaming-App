import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'refresh_notification_token_state.dart';
part 'refresh_notification_token_cubit.freezed.dart';

@injectable
class RefreshNotificationTokenCubit
    extends Cubit<RefreshNotificationTokenState> {
  RefreshNotificationTokenCubit()
      : super(const RefreshNotificationTokenState.initial());

  Future<void> refreshToken({
    required NotificationRefreshTokenDto body,
  }) async {
    try {
      emit(const RefreshNotificationTokenState.loading());

      await api.apiV1NotificationsTokenRefreshPost(body: body);

      emit(
        const RefreshNotificationTokenState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        RefreshNotificationTokenState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
