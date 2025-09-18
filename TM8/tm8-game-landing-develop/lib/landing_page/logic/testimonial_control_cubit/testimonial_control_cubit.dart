import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TestimonialControlCubit extends Cubit<List<int>> {
  TestimonialControlCubit() : super([0, 1]);

  void changeRange({required List<int> changeRange}) {
    emit(changeRange);
  }
}
