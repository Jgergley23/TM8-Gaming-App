import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'fetch_user_groups_state.dart';
part 'fetch_user_groups_cubit.freezed.dart';

@injectable
class FetchUserGroupsCubit extends Cubit<FetchUserGroupsState> {
  FetchUserGroupsCubit() : super(const FetchUserGroupsState.initial());

  Future<void> fetchUserGroups() async {
    try {
      var mainResult = <UserGroupResponseAddedCount>[];
      emit(const FetchUserGroupsState.loading());
      final result = await api.apiV1UsersGroupsGet();

      final resultCounts = await api.apiV1StatisticsUsersGroupCountsGet();

      if (result.isSuccessful) {
        if (resultCounts.isSuccessful) {
          mainResult = _addCountToUserGroups(
            counts: resultCounts.bodyOrThrow,
            userGroups: result.bodyOrThrow,
          );
          emit(
            FetchUserGroupsState.loaded(
              userGroups: mainResult,
              failedValidation: false,
            ),
          );
        }
      } else {
        emit(FetchUserGroupsState.error(error: result.error.toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const FetchUserGroupsState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }

  void reEmitted(bool value) {
    var userGroups = state.whenOrNull(
      loaded: (userGroups, failedValidation) => userGroups,
    );
    emit(
      FetchUserGroupsState.loaded(
        userGroups: userGroups ?? [],
        failedValidation: value,
      ),
    );
  }

  List<UserGroupResponseAddedCount> _addCountToUserGroups({
    required UserGroupCountsResponse counts,
    required List<UserGroupResponse> userGroups,
  }) {
    var mainResult = <UserGroupResponseAddedCount>[];
    final Map<String, double?> statusMapCounts = {
      'All users': counts.allUsers,
      'Apex Legends players': counts.apexLegendsPlayers,
      'Call of Duty players': counts.callOfDutyPlayers,
      'Fortnite players': counts.fortnitePlayers,
      'Rocket League players': counts.rocketLeaguePlayers,
      'Individual user': null,
    };

    for (final item in userGroups) {
      mainResult.add(
        UserGroupResponseAddedCount(
          key: item.key,
          name: item.name,
          count: statusMapCounts[item.name],
        ),
      );
    }

    return mainResult;
  }
}

class UserGroupResponseAddedCount {
  const UserGroupResponseAddedCount({
    required this.key,
    required this.name,
    required this.count,
  });

  final UserGroupResponseKey key;
  final String name;
  final double? count;
}
