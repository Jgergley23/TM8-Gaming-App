import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RebuildEditButtonCubit extends Cubit<bool> {
  RebuildEditButtonCubit() : super(false);

  void rebuild({required bool mainState}) {
    emit(mainState);
  }
}
