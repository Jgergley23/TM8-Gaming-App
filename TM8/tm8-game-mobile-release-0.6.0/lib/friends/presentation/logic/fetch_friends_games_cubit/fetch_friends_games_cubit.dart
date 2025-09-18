import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_friends_games_state.dart';
part 'fetch_friends_games_cubit.freezed.dart';

@injectable
class FetchFriendsGamesCubit extends Cubit<FetchFriendsGamesState> {
  FetchFriendsGamesCubit() : super(const FetchFriendsGamesState.initial());

  Future<void> fetchUserGames({required String userId}) async {
    try {
      emit(const FetchFriendsGamesState.loading());

      final result = await api.apiV1UsersUserIdGamesGet(
        userId: userId,
      );

      emit(
        FetchFriendsGamesState.loaded(
          userGames: result.bodyOrThrow,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(FetchFriendsGamesState.error(error: e.toString()));
    }
  }
}
