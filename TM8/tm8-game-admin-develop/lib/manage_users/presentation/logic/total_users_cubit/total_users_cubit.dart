import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'total_users_state.dart';
part 'total_users_cubit.freezed.dart';

@injectable
class TotalUsersCubit extends Cubit<TotalUsersState> {
  TotalUsersCubit() : super(const TotalUsersState.initial());

  Future<void> fetchTotalUser() async {
    try {
      emit(const TotalUsersState.loading());
      final result = await api.apiV1StatisticsUsersTotalCountGet();

      if (result.isSuccessful) {
        emit(TotalUsersState.loaded(totalCountResponse: result.bodyOrThrow));
      } else {
        final e = jsonDecode(result.error.toString());
        emit(TotalUsersState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(const TotalUsersState.error(error: 'Something went wrong'));
    }
  }
}
