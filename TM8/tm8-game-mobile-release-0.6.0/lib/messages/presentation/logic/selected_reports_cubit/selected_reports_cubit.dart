import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectedReportsCubit extends Cubit<List<String>> {
  SelectedReportsCubit() : super([]);

  Future<void> addReport({required String report}) async {
    final states = [...state];
    if (state.contains(report)) {
      states.remove(report);
    } else {
      states.clear();
      states.add(report);
    }

    emit(states);
  }
}
