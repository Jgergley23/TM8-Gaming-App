import { Game, UserGroup } from 'src/common/constants';

import { GetUserGroupCountsParams } from '../../dto/get-user-group-counts.params';
import { IAggregatedGameUsersCount } from '../../interfaces/aggregated-game-users-count.interface';
import { UserGroupCountsResponse } from '../../response/statistics-user-group-counts.response';

export const aggregateUserGroupCountsMock: IAggregatedGameUsersCount[] = [
  { _id: Game.CallOfDuty, count: 50 },
  { _id: Game.Fortnite, count: 49 },
  { _id: Game.RocketLeague, count: 50 },
  { _id: Game.ApexLegends, count: 50 },
];

export const getUserGroupCountsParamsMock: GetUserGroupCountsParams = {
  userGroups: [
    UserGroup.CallOfDutyPlayers,
    UserGroup.FortnitePlayers,
    UserGroup.RocketLeaguePlayers,
    UserGroup.ApexLegendsPlayers,
    UserGroup.AllUsers,
  ],
};

export const emptyGetUserGroupCountsParamsMock: GetUserGroupCountsParams = {
  userGroups: [],
};

export const assignGameBasedOnUserGroupMock: GetUserGroupCountsParams = {
  userGroups: [
    Game.CallOfDuty,
    Game.Fortnite,
    Game.RocketLeague,
    Game.ApexLegends,
  ],
};

export const userGroupCountsResponseMock: UserGroupCountsResponse = {
  allUsers: 50,
  apexLegendsPlayers: 50,
  rocketLeaguePlayers: 50,
  callOfDutyPlayers: 50,
  fortnitePlayers: 49,
};

export const assignUsersToResultResponseMock: UserGroupCountsResponse = {
  apexLegendsPlayers: 50,
  rocketLeaguePlayers: 50,
  callOfDutyPlayers: 50,
  fortnitePlayers: 49,
};
