import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'send_user_warning_state.dart';
part 'send_user_warning_cubit.freezed.dart';

@injectable
class SendUserWarningCubit extends Cubit<SendUserWarningState> {
  SendUserWarningCubit() : super(const SendUserWarningState.initial());

  Future<void> sendUserWarning({
    required UserWarningInput userWarningInput,
  }) async {
    try {
      emit(const SendUserWarningState.loading());
      final result = await api.apiV1UsersWarningPatch(body: userWarningInput);

      if (result.isSuccessful) {
        emit(SendUserWarningState.loaded(users: result.bodyOrThrow));
      } else {
        final e = jsonDecode(result.error.toString());
        emit(SendUserWarningState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(const SendUserWarningState.error(error: 'Something went wrong'));
    }
  }
}
