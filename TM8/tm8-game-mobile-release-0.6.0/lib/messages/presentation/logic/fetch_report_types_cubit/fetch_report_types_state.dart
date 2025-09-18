part of 'fetch_report_types_cubit.dart';

@freezed
class FetchReportTypesState with _$FetchReportTypesState {
  const factory FetchReportTypesState.initial() = _Initial;
  const factory FetchReportTypesState.loading() = _Loading;
  const factory FetchReportTypesState.loaded({
    required List<UserReportTypeResponse> reportTypes,
  }) = _Loaded;
  const factory FetchReportTypesState.error({required String error}) = _Error;
}
