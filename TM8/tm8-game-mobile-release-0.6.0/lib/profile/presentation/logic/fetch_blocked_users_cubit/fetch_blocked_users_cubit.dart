import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_blocked_users_state.dart';
part 'fetch_blocked_users_cubit.freezed.dart';

@injectable
class FetchBlockedUsersCubit extends Cubit<FetchBlockedUsersState> {
  FetchBlockedUsersCubit() : super(const FetchBlockedUsersState.initial());

  Future<void> fetchBlockedUsers() async {
    try {
      emit(const FetchBlockedUsersState.loading());

      final result = await api.apiV1UsersBlocksGet();

      emit(
        FetchBlockedUsersState.loaded(
          blockedUsers: result.bodyOrThrow,
          fakeDelete: false,
          ids: [],
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        FetchBlockedUsersState.error(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> fakeUnblockUsers({
    required List<String> ids,
    required PaginationMetaResponse meta,
  }) async {
    state.whenOrNull(
      loaded: (blockedUsers, fakeDelete, mainIds) {
        final users = [...blockedUsers.items];
        for (final id in ids) {
          users.removeWhere((element) => element.id == id);
        }
        emit(
          FetchBlockedUsersState.loaded(
            blockedUsers: UserPaginatedResponse(items: users, meta: meta),
            fakeDelete: true,
            ids: ids,
          ),
        );
      },
    );
  }
}
