import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'user_details_state.dart';
part 'user_details_cubit.freezed.dart';

@injectable
class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(const UserDetailsState.initial());

  Future<void> fetchUserDetails({required String userId}) async {
    try {
      emit(const UserDetailsState.loading());
      final result = await api.apiV1UsersUserIdGet(
        userId: userId,
      );

      if (result.isSuccessful) {
        emit(UserDetailsState.loaded(userDetails: result.bodyOrThrow));
      } else {
        final e = jsonDecode(result.error.toString());
        emit(UserDetailsState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(const UserDetailsState.error(error: 'Something went wrong'));
    }
  }
}
