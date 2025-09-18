import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'fetch_warnings_state.dart';
part 'fetch_warnings_cubit.freezed.dart';

@injectable
class FetchWarningsCubit extends Cubit<FetchWarningsState> {
  FetchWarningsCubit() : super(const FetchWarningsState.initial());

  Future<void> fetchWarnings() async {
    try {
      emit(const FetchWarningsState.loading());
      final result = await api.apiV1UsersWarningTypesGet();

      if (result.isSuccessful) {
        emit(
          FetchWarningsState.loaded(
            userWarnings: result.bodyOrThrow,
            validationFailure: false,
          ),
        );
      } else {
        final e = jsonDecode(result.error.toString());
        emit(FetchWarningsState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(const FetchWarningsState.error(error: 'Something went wrong'));
    }
  }

  void reEmitted() {
    var userWarnings = state.whenOrNull(
      loaded: (userWarnings, validationFailure) => userWarnings,
    );
    emit(
      FetchWarningsState.loaded(
        userWarnings: userWarnings ?? [],
        validationFailure: true,
      ),
    );
  }
}
