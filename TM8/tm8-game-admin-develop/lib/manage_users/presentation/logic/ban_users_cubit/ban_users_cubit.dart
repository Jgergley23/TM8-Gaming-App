import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'ban_users_state.dart';
part 'ban_users_cubit.freezed.dart';

@injectable
class BanUsersCubit extends Cubit<BanUsersState> {
  BanUsersCubit() : super(const BanUsersState.initial());

  Future<void> banUser({
    required UserBanInput userBanInput,
    required bool undo,
    required bool rowAction,
  }) async {
    try {
      emit(const BanUsersState.loading());
      final result = await api.apiV1UsersBanPatch(body: userBanInput);

      if (result.isSuccessful) {
        emit(
          BanUsersState.loaded(
            userResponse: result.bodyOrThrow,
            undo: undo,
            note: userBanInput.note,
            onRowAction: rowAction,
          ),
        );
      } else {
        final e = jsonDecode(result.error.toString());
        emit(BanUsersState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const BanUsersState.error(error: 'Something went wrong'),
      );
    }
  }
}
