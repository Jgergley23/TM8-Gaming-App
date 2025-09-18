import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_report_types_state.dart';
part 'fetch_report_types_cubit.freezed.dart';

@injectable
class FetchReportTypesCubit extends Cubit<FetchReportTypesState> {
  FetchReportTypesCubit() : super(const FetchReportTypesState.initial());

  Future<void> fetchReportTypes() async {
    try {
      emit(const FetchReportTypesState.loading());

      final result = await api.apiV1UsersReportTypesGet();

      emit(
        FetchReportTypesState.loaded(reportTypes: result.bodyOrThrow),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        FetchReportTypesState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
