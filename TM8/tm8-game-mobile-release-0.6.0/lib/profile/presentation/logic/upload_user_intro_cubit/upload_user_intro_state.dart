part of 'upload_user_intro_cubit.dart';

@freezed
class UploadUserIntroState with _$UploadUserIntroState {
  const factory UploadUserIntroState.initial() = _Initial;
  const factory UploadUserIntroState.loading() = _Loading;
  const factory UploadUserIntroState.loaded({
    required String audioKey,
  }) = _Loaded;
  const factory UploadUserIntroState.error({required String error}) = _Error;
}
