import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_random_matchmaking_state.dart';
part 'fetch_random_matchmaking_cubit.freezed.dart';

@singleton
class FetchRandomMatchmakingCubit extends Cubit<FetchRandomMatchmakingState> {
  FetchRandomMatchmakingCubit()
      : super(const FetchRandomMatchmakingState.initial());

  Future<void> fetchRandomMatchmaking({required String game}) async {
    try {
      emit(const FetchRandomMatchmakingState.loading());

      final result = await api.apiV1MatchmakingGameResultsGet(
        game: game,
        page: 1,
        limit: 3,
      );

      emit(
        FetchRandomMatchmakingState.loaded(matches: result.bodyOrThrow),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        FetchRandomMatchmakingState.error(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchPageOfMatches({
    required String game,
    required int page,
    required int limit,
  }) async {
    try {
      emit(const FetchRandomMatchmakingState.loading());

      final result = await api.apiV1MatchmakingGameResultsGet(
        game: game,
        page: page,
        limit: limit,
      );

      emit(
        FetchRandomMatchmakingState.loaded(matches: result.bodyOrThrow),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        FetchRandomMatchmakingState.error(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> cleanPage() async {
    emit(
      const FetchRandomMatchmakingState.loaded(
        matches: MatchmakingResultPaginatedResponse(
          items: [],
          meta: PaginationMetaResponse(
            page: 1,
            limit: 3,
            itemCount: 0,
            pageCount: 1,
            hasPreviousPage: false,
            hasNextPage: false,
          ),
        ),
      ),
    );
  }
}
