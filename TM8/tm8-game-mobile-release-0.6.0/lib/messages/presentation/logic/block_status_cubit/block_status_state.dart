part of 'block_status_cubit.dart';

@freezed
class BlockStatusState with _$BlockStatusState {
  const factory BlockStatusState.initial() = _Initial;
  const factory BlockStatusState.loading() = _Loading;
  const factory BlockStatusState.loaded({
    required CheckBlockStatusResponse checkBlockStatus,
  }) = _Loaded;
  const factory BlockStatusState.error({required String error}) = _Error;
}
