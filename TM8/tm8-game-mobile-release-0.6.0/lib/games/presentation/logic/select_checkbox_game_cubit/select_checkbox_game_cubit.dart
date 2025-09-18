import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectCheckboxGameCubit extends Cubit<List<bool>> {
  SelectCheckboxGameCubit() : super([false, false, false, false]);

  Future<void> selectableLen(int index) async {
    final states = List.generate(index, (index) => false);
    emit(states);
  }

  Future<void> changeState(int index) async {
    final states = [...state];
    states[index] = !states[index];
    emit(states);
  }
}
