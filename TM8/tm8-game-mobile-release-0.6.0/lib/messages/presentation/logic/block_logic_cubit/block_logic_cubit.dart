import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BlockLogicCubit extends Cubit<bool> {
  BlockLogicCubit() : super(false);

  Future<void> blockLogic({required bool block}) async {
    emit(block);
  }
}
