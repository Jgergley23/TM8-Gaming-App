part of 'download_intro_cubit.dart';

@freezed
class DownloadIntroState with _$DownloadIntroState {
  const factory DownloadIntroState.initial() = _Initial;
  const factory DownloadIntroState.loading() = _Loading;
  const factory DownloadIntroState.loaded({required DeviceFileSource source}) =
      _Loaded;
  const factory DownloadIntroState.error({required String error}) = _Error;
}
