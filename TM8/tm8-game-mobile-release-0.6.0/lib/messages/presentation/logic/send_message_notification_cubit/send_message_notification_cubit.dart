import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'send_message_notification_state.dart';
part 'send_message_notification_cubit.freezed.dart';

@injectable
class SendMessageNotificationCubit extends Cubit<SendMessageNotificationState> {
  SendMessageNotificationCubit()
      : super(const SendMessageNotificationState.initial());

  Future<void> sendMessage({required CreateMessageNotificationDto body}) async {
    try {
      emit(const SendMessageNotificationState.loading());

      await api.apiV1NotificationsMessagePost(body: body);

      emit(
        const SendMessageNotificationState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        SendMessageNotificationState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
