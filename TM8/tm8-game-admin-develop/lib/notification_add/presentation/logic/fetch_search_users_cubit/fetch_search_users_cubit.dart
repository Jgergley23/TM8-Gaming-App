import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'fetch_search_users_state.dart';
part 'fetch_search_users_cubit.freezed.dart';

@injectable
class FetchSearchUsersCubit extends Cubit<FetchSearchUsersState> {
  FetchSearchUsersCubit() : super(const FetchSearchUsersState.initial());

  Future<void> fetchNotificationIntervals({required String username}) async {
    try {
      emit(const FetchSearchUsersState.loading());
      final result =
          await api.apiV1UsersUsernameUsernameGet(username: username);

      if (result.isSuccessful) {
        emit(
          FetchSearchUsersState.loaded(
            users: result.bodyOrThrow,
          ),
        );
      } else {
        emit(
          FetchSearchUsersState.error(
            error: result.handleError,
          ),
        );
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const FetchSearchUsersState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }
}
