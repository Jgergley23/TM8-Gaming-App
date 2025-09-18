// ignore_for_file: unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'camera_permission_state.dart';
part 'camera_permission_cubit.freezed.dart';

@injectable
class CameraPermissionCubit extends Cubit<CameraPermissionState> {
  CameraPermissionCubit() : super(const CameraPermissionState.initial());

  Future<void> checkCameraPermission() async {
    try {
      emit(const CameraPermissionState.loading());
      // add for ios permission
      final permissionStatus = await Permission.camera.status;
      final permission = await Permission.camera.request();
      emit(CameraPermissionState.loaded(permissionStatus: permission));
    } catch (e) {
      final permissionStatus = await Permission.camera.status;
      emit(
        CameraPermissionState.loaded(
          permissionStatus: permissionStatus,
        ),
      );
    }
  }
}
