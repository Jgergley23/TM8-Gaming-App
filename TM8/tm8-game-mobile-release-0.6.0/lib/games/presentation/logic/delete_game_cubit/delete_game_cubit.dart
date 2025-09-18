import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';

part 'delete_game_state.dart';
part 'delete_game_cubit.freezed.dart';

@injectable
class DeleteGameCubit extends Cubit<DeleteGameState> {
  DeleteGameCubit() : super(const DeleteGameState.initial());

  Future<void> deleteGame({required String game}) async {
    try {
      emit(const DeleteGameState.loading());

      await api.apiV1UsersUserIdGameGameDelete(
        userId: sl<Tm8Storage>().userId,
        game: game,
      );

      emit(
        const DeleteGameState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        DeleteGameState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
