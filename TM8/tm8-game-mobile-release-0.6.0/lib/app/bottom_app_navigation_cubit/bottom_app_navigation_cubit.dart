import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// bottom app navigation cubit which decides which icon is selected on bottom app bar
@injectable
class BottomAppNavigationCubit extends Cubit<List<bool>> {
  BottomAppNavigationCubit() : super([true, false, false, false, false]);

  Future<void> emitNewPage({required int index}) async {
    List<bool> states = [...state];
    states = List<bool>.filled(5, false);
    states[index] = !states[index];
    emit(states);
  }
}
