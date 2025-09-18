import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AudioControllerCubit extends Cubit<bool> {
  AudioControllerCubit() : super(false);

  Future<void> changePlaying(bool isPlaying) async {
    emit(isPlaying);
  }
}
