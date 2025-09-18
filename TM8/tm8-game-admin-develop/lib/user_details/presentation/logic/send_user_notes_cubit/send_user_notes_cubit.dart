import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'send_user_notes_state.dart';
part 'send_user_notes_cubit.freezed.dart';

@injectable
class SendUserNotesCubit extends Cubit<SendUserNotesState> {
  SendUserNotesCubit() : super(const SendUserNotesState.initial());

  Future<void> sendUserNotes({
    required String userId,
    required UserNoteInput notes,
  }) async {
    try {
      emit(const SendUserNotesState.loading());
      final result = await api.apiV1UsersUserIdAdminNotePatch(
        body: notes,
        userId: userId,
      );

      if (result.isSuccessful) {
        emit(SendUserNotesState.loaded(user: result.bodyOrThrow));
      } else {
        emit(SendUserNotesState.error(error: result.handleError));
      }
    } catch (e) {
      logError(e.toString());
      emit(const SendUserNotesState.error(error: 'Something went wrong'));
    }
  }
}
