import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'added_games_state.dart';
part 'added_games_cubit.freezed.dart';

@injectable
class AddedGamesCubit extends Cubit<AddedGamesState> {
  AddedGamesCubit() : super(const AddedGamesState.initial());

  Future<void> fetchUserGames({required String userId}) async {
    try {
      emit(const AddedGamesState.loading());
      final result = await api.apiV1UsersUserIdPreferencesGet(
        userId: userId,
      );

      if (result.isSuccessful) {
        emit(AddedGamesState.loaded(userGameDataResponse: result.bodyOrThrow));
      } else {
        final e = jsonDecode(result.error.toString());
        emit(AddedGamesState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(const AddedGamesState.error(error: 'Something went wrong'));
    }
  }
}
