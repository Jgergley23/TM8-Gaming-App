import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'manage_admins_state.dart';
part 'manage_admins_cubit.freezed.dart';

@injectable
class ManageAdminsCubit extends Cubit<ManageAdminsState> {
  ManageAdminsCubit() : super(const ManageAdminsState.initial());

  Future<void> fetchAdminsData({
    required AdminsTableDataFilters filters,
  }) async {
    try {
      String? message;
      emit(ManageAdminsState.loading(length: filters.rowSize));
      final result = await api.apiV1UsersGet(
        page: filters.page,
        limit: filters.rowSize,
        name: filters.search,
        sort: filters.sort,
        roles: ['superadmin,admin'],
      );

      if (result.isSuccessful) {
        if (filters.search != null && result.bodyOrThrow.items.isEmpty) {
          message = 'No results found';
        }
        emit(
          ManageAdminsState.loaded(
            adminsResponse: result.bodyOrThrow,
            message: message,
            filters: filters,
          ),
        );
      } else {
        emit(ManageAdminsState.error(error: result.handleError));
      }
    } catch (e) {
      logError(e.toString());
      emit(const ManageAdminsState.error(error: 'Something went wrong'));
    }
  }

  void fakeDeletedAdmin({required List<String> ids}) {
    state.whenOrNull(
      loaded: (adminsResponse, message, filters) {
        final admins = [...adminsResponse.items];
        for (final id in ids) {
          admins.removeWhere((element) => element.id == id);
        }
        emit(
          ManageAdminsState.loaded(
            adminsResponse: adminsResponse.copyWith(items: admins),
            message: message,
            filters: filters,
          ),
        );
      },
    );
  }
}

class AdminsTableDataFilters {
  AdminsTableDataFilters({
    required this.page,
    required this.rowSize,
    this.search,
    this.sort,
  });

  final int page;
  final int rowSize;
  String? search;
  String? sort;
}
