import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'send_call_notification_state.dart';
part 'send_call_notification_cubit.freezed.dart';

@injectable
class SendCallNotificationCubit extends Cubit<SendCallNotificationState> {
  SendCallNotificationCubit()
      : super(const SendCallNotificationState.initial());

  Future<void> sendCall({required CreateCallNotificationDto body}) async {
    try {
      emit(const SendCallNotificationState.loading());

      await api.apiV1NotificationsCallPost(body: body);

      emit(
        const SendCallNotificationState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        SendCallNotificationState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
