import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'manage_users_state.dart';
part 'manage_users_cubit.freezed.dart';

@injectable
class ManageUsersCubit extends Cubit<ManageUsersState> {
  ManageUsersCubit() : super(const ManageUsersState.initial());

  Future<void> fetchTableData({
    required UsersTableDataFilters filters,
  }) async {
    try {
      emit(ManageUsersState.loading(length: filters.rowSize));
      final result = await api.apiV1UsersGet(
        page: filters.page,
        limit: filters.rowSize,
        status: filters.status,
        username: filters.search,
        sort: filters.sort,
        roles: ['user'],
      );

      if (result.isSuccessful && result.body != null) {
        if (result.body!.items.isEmpty) {
          if (filters.status != null) {
            emit(
              ManageUsersState.loaded(
                userPaginatedResponse: result.body!,
                message: 'No filter results.',
                filters: filters,
              ),
            );
          } else if (filters.search != null) {
            emit(
              ManageUsersState.loaded(
                userPaginatedResponse: result.body!,
                message: 'No results found.',
                filters: filters,
              ),
            );
          } else {
            emit(
              ManageUsersState.loaded(
                userPaginatedResponse: result.body!,
                filters: filters,
                message: 'No users found.',
              ),
            );
          }
        } else {
          emit(
            ManageUsersState.loaded(
              userPaginatedResponse: result.body!,
              filters: filters,
            ),
          );
        }
      } else {
        if (result.body == null) {
          emit(const ManageUsersState.error(error: 'Something went wrong'));
        } else {
          final e = jsonDecode(result.error.toString());
          emit(ManageUsersState.error(error: e['detail'].toString()));
        }
      }
    } catch (e) {
      logError(e.toString());
      emit(const ManageUsersState.error(error: 'Something went wrong'));
    }
  }
}

class UsersTableDataFilters {
  UsersTableDataFilters({
    required this.page,
    required this.rowSize,
    this.status,
    this.search,
    this.sort,
  });

  final int page;
  final int rowSize;
  ApiV1UsersGetStatus? status;
  String? search;
  String? sort;
}
