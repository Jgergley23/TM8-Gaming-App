import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectedBlockedUsersCubit extends Cubit<List<bool>> {
  SelectedBlockedUsersCubit() : super([]);

  Future<void> init(int length) async {
    emit(List.generate(length, (index) => false));
  }

  Future<void> changeState(int index) async {
    final list = [...state];
    list[index] = !list[index];
    emit(list);
  }
}
