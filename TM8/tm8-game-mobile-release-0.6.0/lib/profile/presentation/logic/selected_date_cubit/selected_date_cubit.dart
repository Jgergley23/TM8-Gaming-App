import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectedDateCubit extends Cubit<DateTime> {
  SelectedDateCubit() : super(DateTime.now());

  Future<void> changeDate(DateTime time) async {
    emit(time);
  }
}
