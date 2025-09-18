import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UnfocusDropDownCubit extends Cubit<bool> {
  UnfocusDropDownCubit() : super(false);

  Future<void> unfocus() async {
    emit(!state);
  }
}
