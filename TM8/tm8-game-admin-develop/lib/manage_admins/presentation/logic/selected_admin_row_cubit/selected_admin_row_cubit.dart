import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectedAdminRowCubit extends Cubit<List<String>> {
  SelectedAdminRowCubit() : super([]);

  void addSelectedAdmin(String selectedAdminId) {
    final List<String> selectedAdmins = [...state];
    if (selectedAdmins.contains(selectedAdminId)) {
      selectedAdmins.remove(selectedAdminId);
      emit(selectedAdmins);
    } else {
      selectedAdmins.add(selectedAdminId);
      emit(selectedAdmins);
    }
  }

//this Function resets selected rows or adds all rows as selected
//example it is used on changing of filters for resetting selected rows
  void addRemoveAllAdmins({
    required bool value,
    required List<String> selectedAdminId,
  }) {
    final List<String> selectedAdmins = [];
    if (value) {
      selectedAdmins.addAll(selectedAdminId);
    } else {
      selectedAdmins.clear();
    }
    emit(selectedAdmins);
  }
}
