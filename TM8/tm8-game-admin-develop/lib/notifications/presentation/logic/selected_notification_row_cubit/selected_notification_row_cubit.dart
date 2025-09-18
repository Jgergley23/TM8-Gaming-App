import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectedNotificationRowCubit extends Cubit<List<String>> {
  SelectedNotificationRowCubit() : super([]);

  void addSelectedNotification(String selectedNotificationId) {
    final List<String> selectedNotifications = [...state];
    if (selectedNotifications.contains(selectedNotificationId)) {
      selectedNotifications.remove(selectedNotificationId);
      emit(selectedNotifications);
    } else {
      selectedNotifications.add(selectedNotificationId);
      emit(selectedNotifications);
    }
  }

//this Function resets selected rows or adds all rows as selected
//example it is used on changing of filters for resetting selected rows
  void addRemoveAllNotifications({
    required bool value,
    required List<String> selectedNotificationIds,
  }) {
    final List<String> selectedNotifications = [];
    if (value) {
      selectedNotifications.addAll(selectedNotificationIds);
    } else {
      selectedNotifications.clear();
    }
    emit(selectedNotifications);
  }
}
