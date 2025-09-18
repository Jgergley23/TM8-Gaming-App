part of 'report_user_cubit.dart';

@freezed
class ReportUserState with _$ReportUserState {
  const factory ReportUserState.initial() = _Initial;
  const factory ReportUserState.loading() = _Loading;
  const factory ReportUserState.loaded() = _Loaded;
  const factory ReportUserState.error({required String error}) = _Error;
}
