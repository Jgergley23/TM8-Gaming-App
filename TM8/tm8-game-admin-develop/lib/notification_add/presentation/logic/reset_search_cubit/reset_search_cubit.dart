import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetSearchCubit extends Cubit<bool> {
  ResetSearchCubit() : super(false);

  void resetSearch() {
    emit(!state);
  }
}
