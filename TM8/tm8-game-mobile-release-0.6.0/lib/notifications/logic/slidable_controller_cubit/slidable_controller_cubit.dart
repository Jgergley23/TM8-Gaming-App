import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class SlidableControllerCubit extends Cubit<bool> {
  SlidableControllerCubit() : super(false);

  void open() {
    final mainState = state;
    emit(!mainState);
  }
}
