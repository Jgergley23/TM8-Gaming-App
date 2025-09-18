// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'update_user_photo_state.dart';
part 'update_user_photo_cubit.freezed.dart';

@injectable
class UpdateUserPhotoCubit extends Cubit<UpdateUserPhotoState> {
  UpdateUserPhotoCubit() : super(const UpdateUserPhotoState.initial());

  Future<void> updateUserPhoto({required int value}) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? image;
      if (value == 0) {
        image = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 30,
        );
      } else {
        image = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 40,
        );
      }

      emit(const UpdateUserPhotoState.loading());

      if (image != null) {
        final validExtensions = [
          'png',
          'jpeg',
          'jpg',
        ];
        final extension = image.name.split('.').last.toLowerCase();

        if (validExtensions.contains(extension)) {
          final accessToken = sl<Tm8Storage>().accessToken;

          // Create a multipart request
          var request = http.MultipartRequest(
            'PATCH',
            Uri.parse('https://${Env.stagingUrl}/api/v1/users/image'),
          );

          // Add headers
          request.headers['Authorization'] = 'Bearer $accessToken';

          // Add the image file
          request.files.add(
            await http.MultipartFile.fromPath(
              'file',
              image.path,
              contentType: MediaType('image', 'jpeg'),
            ),
          );

          var response = await request.send();

          var mainResponse = await http.Response.fromStream(response);
          final json = jsonDecode(mainResponse.body) as Map<String, dynamic>;

          emit(
            UpdateUserPhotoState.loaded(
              userFileResponse: SetUserFileResponse(key: json['key']),
            ),
          );
        } else {
          emit(
            const UpdateUserPhotoState.error(
              error: 'Extension not supported',
            ),
          );
        }
      } else {
        emit(
          const UpdateUserPhotoState.error(
            error: 'No image selected',
          ),
        );
      }
      sl<FetchUserProfileCubit>().fetchUserProfile();
      sl<FetchChannelsCubit>().fetchChannels(username: null);
    } catch (e) {
      logError(e.toString());
      emit(
        UpdateUserPhotoState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
