part of 'fetch_match_id_cubit.dart';

@freezed
class FetchMatchIdState with _$FetchMatchIdState {
  const factory FetchMatchIdState.initial() = _Initial;
  const factory FetchMatchIdState.loading() = _Loading;
  const factory FetchMatchIdState.loaded({
    required CheckMatchExistsResponse matchCheck,
  }) = _Loaded;
  const factory FetchMatchIdState.error({required String error}) = _Error;
}
