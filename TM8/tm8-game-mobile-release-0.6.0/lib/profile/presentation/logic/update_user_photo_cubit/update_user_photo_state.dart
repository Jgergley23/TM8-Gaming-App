part of 'update_user_photo_cubit.dart';

@freezed
class UpdateUserPhotoState with _$UpdateUserPhotoState {
  const factory UpdateUserPhotoState.initial() = _Initial;
  const factory UpdateUserPhotoState.loading() = _Loading;
  const factory UpdateUserPhotoState.loaded({
    required SetUserFileResponse userFileResponse,
  }) = _Loaded;
  const factory UpdateUserPhotoState.error({required String error}) = _Error;
}
