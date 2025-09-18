// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';

part 'upload_user_intro_state.dart';
part 'upload_user_intro_cubit.freezed.dart';

@injectable
class UploadUserIntroCubit extends Cubit<UploadUserIntroState> {
  UploadUserIntroCubit() : super(const UploadUserIntroState.initial());

  Future<void> uploadIntro({required String recordPath}) async {
    try {
      emit(const UploadUserIntroState.loading());

      final accessToken = sl<Tm8Storage>().accessToken;
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('https://${Env.stagingUrl}/api/v1/users/audio-intro'),
      );

      // Add headers
      request.headers['Authorization'] = 'Bearer $accessToken';

      // Add the image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          recordPath,
          contentType: MediaType('audio', 'mpeg'),
        ),
      );

      var response = await request.send();

      var mainResponse = await http.Response.fromStream(response);
      final json = jsonDecode(mainResponse.body) as Map<String, dynamic>;
      emit(
        UploadUserIntroState.loaded(
          audioKey: json['key'],
        ),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
    } catch (e) {
      logError(e.toString());
      emit(
        UploadUserIntroState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
