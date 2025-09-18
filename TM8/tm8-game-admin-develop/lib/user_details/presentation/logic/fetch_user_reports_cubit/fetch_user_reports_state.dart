part of 'fetch_user_reports_cubit.dart';

@freezed
class FetchUserReportsState with _$FetchUserReportsState {
  const factory FetchUserReportsState.initial() = _Initial;
  const factory FetchUserReportsState.loading() = _Loading;
  const factory FetchUserReportsState.loaded({
    required List<UserReportResponse> reports,
  }) = _Loaded;
  const factory FetchUserReportsState.error({
    required String error,
  }) = _Error;
}
