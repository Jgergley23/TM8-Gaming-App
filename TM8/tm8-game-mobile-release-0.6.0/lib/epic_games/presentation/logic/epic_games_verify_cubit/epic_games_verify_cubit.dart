import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/handlers/error_handler.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'epic_games_verify_state.dart';
part 'epic_games_verify_cubit.freezed.dart';

// cubit which verifies the epic games account
@injectable
class EpicGamesVerifyCubit extends Cubit<EpicGamesVerifyState> {
  EpicGamesVerifyCubit() : super(const EpicGamesVerifyState.initial());

  Future<void> epicGamesVerify({required EpicGamesVerifyInput body}) async {
    try {
      emit(const EpicGamesVerifyState.loading());

      final result = await api.apiV1AuthEpicGamesVerifyPost(body: body);

      if (result.isSuccessful) {
        emit(const EpicGamesVerifyState.loaded());
      } else {
        emit(EpicGamesVerifyState.error(error: result.handleError));
      }
    } catch (e) {
      logError(e.toString());
      emit(const EpicGamesVerifyState.error(error: 'Something went wrong'));
    }
  }
}
