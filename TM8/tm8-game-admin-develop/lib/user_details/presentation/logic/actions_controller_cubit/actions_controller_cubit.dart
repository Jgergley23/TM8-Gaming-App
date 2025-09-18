import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ActionsControllerCubit extends Cubit<bool> {
  ActionsControllerCubit() : super(true);

  void changeControllerState(bool change) {
    emit(change);
  }
}
