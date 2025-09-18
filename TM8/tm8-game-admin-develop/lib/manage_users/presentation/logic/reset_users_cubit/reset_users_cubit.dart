import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'reset_users_state.dart';
part 'reset_users_cubit.freezed.dart';

@injectable
class ResetUserCubit extends Cubit<ResetUserState> {
  ResetUserCubit() : super(const ResetUserState.initial());

  Future<void> resetUser({
    required UserResetInput userResetInput,
    required bool undo,
    required String note,
    required bool rowAction,
  }) async {
    try {
      emit(const ResetUserState.loading());
      final result = await api.apiV1UsersResetPatch(body: userResetInput);

      if (result.isSuccessful) {
        emit(
          ResetUserState.loaded(
            userResponse: result.bodyOrThrow,
            undo: undo,
            note: note,
            rowAction: rowAction,
          ),
        );
      } else {
        final e = jsonDecode(result.error.toString());
        emit(ResetUserState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const ResetUserState.error(error: 'Something went wrong'),
      );
    }
  }
}
