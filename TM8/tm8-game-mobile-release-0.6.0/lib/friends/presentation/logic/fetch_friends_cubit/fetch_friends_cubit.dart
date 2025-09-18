import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_friends_state.dart';
part 'fetch_friends_cubit.freezed.dart';

@singleton
class FetchFriendsCubit extends Cubit<FetchFriendsState> {
  FetchFriendsCubit() : super(const FetchFriendsState.initial());

  Future<void> fetchFriends({required String? username}) async {
    try {
      emit(const FetchFriendsState.loading(friendList: []));

      final result = await api.apiV1UsersFriendsGet(
        page: 1,
        limit: 20,
        username: username,
      );

      emit(
        FetchFriendsState.loaded(
          friendList: result.bodyOrThrow,
          username: username,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(FetchFriendsState.error(error: e.toString()));
    }
  }

  Future<void> fetchNextPage({
    required String? username,
    required int page,
    required List<UserResponse> friendList,
  }) async {
    try {
      emit(FetchFriendsState.loading(friendList: friendList));

      final result = await api.apiV1UsersFriendsGet(
        page: page,
        limit: 20,
        username: username,
      );

      emit(
        FetchFriendsState.loaded(
          friendList: UserPaginatedResponse(
            items: friendList + result.bodyOrThrow.items,
            meta: result.bodyOrThrow.meta,
          ),
          username: username,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(FetchFriendsState.error(error: e.toString()));
    }
  }
}
