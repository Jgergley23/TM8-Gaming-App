import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AudioControllerCubit extends Cubit<bool> {
  AudioControllerCubit() : super(true);

  Future<void> changeSetting({required bool enabled}) async {
    emit(enabled);
  }
}
