import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';

part 'delete_epic_games_state.dart';
part 'delete_epic_games_cubit.freezed.dart';

@injectable
class DeleteEpicGamesCubit extends Cubit<DeleteEpicGamesState> {
  DeleteEpicGamesCubit() : super(const DeleteEpicGamesState.initial());

  Future<void> deleteEpicAccount() async {
    try {
      emit(const DeleteEpicGamesState.loading());

      await api.apiV1AuthEpicGamesDelete();

      emit(
        const DeleteEpicGamesState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        DeleteEpicGamesState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
