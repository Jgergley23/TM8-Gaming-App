import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.enums.swagger.dart';

@injectable
class SelectedRowUsersCubit extends Cubit<List<SelectedUser>> {
  SelectedRowUsersCubit() : super(<SelectedUser>[]);

  void addSelectedUser(SelectedUser selectedUser) {
    final List<SelectedUser> selectedUsers = [...state];
    if (selectedUsers.any((element) => element.id == selectedUser.id)) {
      selectedUsers.removeWhere((element) => element.id == selectedUser.id);
      emit(selectedUsers);
    } else {
      selectedUsers.add(selectedUser);
      emit(selectedUsers);
    }
  }

  void addRemoveAllUsers({
    required bool value,
    required List<SelectedUser> mainSelectedUsers,
  }) {
    final List<SelectedUser> selectedUsers = [];
    if (value) {
      selectedUsers.addAll(mainSelectedUsers);
    } else {
      selectedUsers.clear();
    }
    emit(selectedUsers);
  }

  void reEmitBanned() {
    final List<SelectedUser> selectedUsers = [...state];
    selectedUsers.removeWhere(
      (element) =>
          element.status == UserStatusResponseType.active ||
          element.status == UserStatusResponseType.reported,
    );
    emit(selectedUsers);
  }

  void reEmitReset() {
    final List<SelectedUser> selectedUsers = [...state];
    selectedUsers.removeWhere(
      (element) =>
          element.status == UserStatusResponseType.banned ||
          element.status == UserStatusResponseType.suspended,
    );
    emit(selectedUsers);
  }

  void reEmitRowAction({required String id}) {
    final List<SelectedUser> selectedUsers = [...state];
    selectedUsers.removeWhere(
      (element) => element.id == id,
    );
    emit(selectedUsers);
  }
}

class SelectedUser {
  final String id;
  final UserStatusResponseType status;
  final String? note;

  SelectedUser({
    required this.id,
    required this.status,
    required this.note,
  });
}
