import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'search_users_state.dart';
part 'search_users_cubit.freezed.dart';

@injectable
class SearchUsersCubit extends Cubit<SearchUsersState> {
  SearchUsersCubit() : super(const SearchUsersState.initial());

  Future<void> searchUsers({required String username}) async {
    try {
      emit(const SearchUsersState.loading());

      final result = await api.apiV1UsersSearchGet(
        username: username,
      );

      emit(
        SearchUsersState.loaded(response: result.bodyOrThrow),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        SearchUsersState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
