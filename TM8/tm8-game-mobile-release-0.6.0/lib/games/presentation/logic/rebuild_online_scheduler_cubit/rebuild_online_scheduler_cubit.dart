import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RebuildOnlineSchedulerCubit extends Cubit<bool> {
  RebuildOnlineSchedulerCubit() : super(false);

  Future<void> rebuild() async {
    emit(!state);
  }
}
