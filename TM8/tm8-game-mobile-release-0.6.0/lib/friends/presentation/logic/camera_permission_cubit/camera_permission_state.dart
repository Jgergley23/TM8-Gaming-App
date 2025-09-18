part of 'camera_permission_cubit.dart';

@freezed
class CameraPermissionState with _$CameraPermissionState {
  const factory CameraPermissionState.initial() = _Initial;
  const factory CameraPermissionState.loading() = _Loading;
  const factory CameraPermissionState.loaded({
    required PermissionStatus permissionStatus,
  }) = _Loaded;
}
