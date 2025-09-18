part of 'fetch_warnings_cubit.dart';

@freezed
class FetchWarningsState with _$FetchWarningsState {
  const factory FetchWarningsState.initial() = _Initial;
  const factory FetchWarningsState.loading() = _Loading;
  const factory FetchWarningsState.loaded({
    required List<UserWarningTypeResponse> userWarnings,
    required bool validationFailure,
  }) = _Loaded;
  const factory FetchWarningsState.error({
    required String error,
  }) = _Error;
}
