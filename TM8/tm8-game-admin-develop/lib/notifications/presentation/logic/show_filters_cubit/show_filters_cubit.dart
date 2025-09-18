import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShowFiltersCubit extends Cubit<bool> {
  ShowFiltersCubit() : super(false);

  void changeVisibility(bool value) {
    emit(value);
  }
}
