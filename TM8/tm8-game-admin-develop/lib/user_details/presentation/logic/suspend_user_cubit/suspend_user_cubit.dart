import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'suspend_user_state.dart';
part 'suspend_user_cubit.freezed.dart';

@injectable
class SuspendUserCubit extends Cubit<SuspendUserState> {
  SuspendUserCubit() : super(const SuspendUserState.initial());

  Future<void> suspendUser({required UserSuspendInput userSuspendInput}) async {
    try {
      emit(const SuspendUserState.loading());
      final result = await api.apiV1UsersSuspendPatch(body: userSuspendInput);

      if (result.isSuccessful) {
        emit(
          SuspendUserState.loaded(
            userSuspended: result.bodyOrThrow,
          ),
        );
      } else {
        final e = jsonDecode(result.error.toString());
        emit(SuspendUserState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(const SuspendUserState.error(error: 'Something went wrong'));
    }
  }
}
