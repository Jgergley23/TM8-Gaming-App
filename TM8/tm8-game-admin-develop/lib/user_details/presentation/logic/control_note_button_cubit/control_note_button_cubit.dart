import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ControlNoteButtonCubit extends Cubit<bool> {
  ControlNoteButtonCubit() : super(false);

  void changeButtonState(bool changed) {
    emit(changed);
  }
}
