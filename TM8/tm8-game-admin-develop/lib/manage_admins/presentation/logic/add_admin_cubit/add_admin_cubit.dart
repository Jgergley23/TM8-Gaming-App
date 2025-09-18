import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'add_admin_state.dart';
part 'add_admin_cubit.freezed.dart';

@injectable
class AddAdminCubit extends Cubit<AddAdminState> {
  AddAdminCubit() : super(const AddAdminState.initial());

  Future<void> addAdmin({
    required CreateAdminInput body,
  }) async {
    try {
      emit(const AddAdminState.loading());
      final result = await api.apiV1UsersAdminPost(
        body: body,
      );

      if (result.isSuccessful) {
        emit(
          const AddAdminState.loaded(),
        );
      } else {
        emit(AddAdminState.error(error: result.handleError));
      }
    } catch (e) {
      logError(e.toString());
      emit(const AddAdminState.error(error: 'Something went wrong'));
    }
  }
}
