import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class RefetchNotificationTableCubit extends Cubit<bool> {
  RefetchNotificationTableCubit() : super(false);

  void refetch(bool fetch) {
    emit(fetch);
  }
}
