import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'delete_admin_state.dart';
part 'delete_admin_cubit.freezed.dart';

@injectable
class DeleteAdminCubit extends Cubit<DeleteAdminState> {
  DeleteAdminCubit() : super(const DeleteAdminState.initial());

  Future<void> deleteAdmin({
    required DeleteUsersInput body,
  }) async {
    try {
      emit(const DeleteAdminState.loading());
      final result = await api.apiV1UsersDelete(
        body: body,
      );

      if (result.isSuccessful) {
        emit(
          const DeleteAdminState.loaded(),
        );
      } else {
        emit(DeleteAdminState.error(error: result.handleError));
      }
    } catch (e) {
      logError(e.toString());
      emit(const DeleteAdminState.error(error: 'Something went wrong'));
    }
  }
}
