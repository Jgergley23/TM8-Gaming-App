import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'fetch_user_reports_state.dart';
part 'fetch_user_reports_cubit.freezed.dart';

@injectable
class FetchUserReportsCubit extends Cubit<FetchUserReportsState> {
  FetchUserReportsCubit() : super(const FetchUserReportsState.initial());

  Future<void> fetchUserReports({required String userId}) async {
    try {
      emit(const FetchUserReportsState.loading());
      final result = await api.apiV1UsersUserIdReportsGet(userId: userId);

      if (result.isSuccessful) {
        emit(
          FetchUserReportsState.loaded(reports: result.bodyOrThrow),
        );
      } else {
        emit(FetchUserReportsState.error(error: result.handleError));
      }
    } catch (e) {
      logError(e.toString());
      emit(const FetchUserReportsState.error(error: 'Something went wrong'));
    }
  }
}
