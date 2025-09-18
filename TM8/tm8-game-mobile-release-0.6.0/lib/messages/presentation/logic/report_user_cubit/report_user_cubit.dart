import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'report_user_state.dart';
part 'report_user_cubit.freezed.dart';

@injectable
class ReportUserCubit extends Cubit<ReportUserState> {
  ReportUserCubit() : super(const ReportUserState.initial());

  Future<void> reportUsers({
    required ReportUserInput body,
    required String userId,
  }) async {
    try {
      emit(const ReportUserState.loading());

      await api.apiV1UsersUserIdReportPost(
        body: body,
        userId: userId,
      );

      emit(
        const ReportUserState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        ReportUserState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
