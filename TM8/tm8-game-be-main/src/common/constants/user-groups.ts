import { UserGroup } from 'src/common/constants';

import { IUserGroup } from '../interfaces/user-group.interface';

export const userGroupsResponse: IUserGroup[] = [
  {
    key: UserGroup.AllUsers,
    name: 'All users',
  },
  {
    key: UserGroup.ApexLegendsPlayers,
    name: 'Apex Legends players',
  },
  {
    key: UserGroup.CallOfDutyPlayers,
    name: 'Call of Duty players',
  },
  {
    key: UserGroup.FortnitePlayers,
    name: 'Fortnite players',
  },
  {
    key: UserGroup.RocketLeaguePlayers,
    name: 'Rocket League players',
  },
  {
    key: UserGroup.IndividualUser,
    name: 'Individual user',
  },
];
