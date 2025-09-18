import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShowSearchUserCubit extends Cubit<bool> {
  ShowSearchUserCubit() : super(false);

  void changeShowSearchUser(bool value) {
    emit(value);
  }
}
