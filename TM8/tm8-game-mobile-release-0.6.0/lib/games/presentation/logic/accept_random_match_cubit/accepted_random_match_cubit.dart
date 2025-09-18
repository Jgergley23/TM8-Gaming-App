import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AcceptedRandomMatchCubit extends Cubit<List<bool>> {
  AcceptedRandomMatchCubit() : super([false, false, false]);

  Future<void> changeState(int index) async {
    final states = [...state];
    states[index] = !states[index];
    emit(states);
  }
}
