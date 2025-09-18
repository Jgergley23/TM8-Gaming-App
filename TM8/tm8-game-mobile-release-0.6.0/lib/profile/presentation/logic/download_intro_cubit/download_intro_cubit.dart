import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tm8/env/env.dart';

part 'download_intro_state.dart';
part 'download_intro_cubit.freezed.dart';

@injectable
class DownloadIntroCubit extends Cubit<DownloadIntroState> {
  DownloadIntroCubit() : super(const DownloadIntroState.initial());

  Future<void> downloadIntro({required String audioKey}) async {
    try {
      emit(const DownloadIntroState.loading());
      var response = await http.get(
        Uri.parse(
          '${Env.stagingUrlAmazon}/$audioKey',
        ),
      );
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/audio.mp3');
        await file.writeAsBytes(bytes);
        final source = DeviceFileSource(file.path);

        emit(DownloadIntroState.loaded(source: source));
      } else {
        throw Exception('Failed to download audio file');
      }
    } catch (e) {
      logError(e.toString());
      emit(
        DownloadIntroState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
