import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';

@injectable
class FaqControllerCubit extends Cubit<List<bool>> {
  FaqControllerCubit()
      : super(
          List.generate(7, (index) => false),
        );

  void update(int index) {
    final list = [...state];
    list[index] = !list[index];
    logInfo(list);
    emit(list);
  }
}
