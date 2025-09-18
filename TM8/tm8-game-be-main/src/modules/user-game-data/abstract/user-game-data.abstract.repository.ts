import { Injectable } from '@nestjs/common';
import { FilterQuery } from 'mongoose';

import { AbstractRepository } from 'src/common/abstract/abstract.repository';
import { IAggregatedGameUsersCount } from 'src/modules/statistics/interfaces/aggregated-game-users-count.interface';

import { UserGameData } from '../schemas/user-game-data.schema';

@Injectable()
export abstract class AbstractUserGameDataRepository extends AbstractRepository<UserGameData> {
  abstract countUsersPerGame(
    requiredGroups: string[],
  ): Promise<IAggregatedGameUsersCount[]>;
  abstract getUserGameDataWithUsers(
    filter: FilterQuery<UserGameData>,
  ): Promise<UserGameData[]>;
  abstract getUserGameDataWithUserMatchmakingData(
    filter: FilterQuery<UserGameData>,
  ): Promise<UserGameData[]>;
  abstract getUserGameDataWithMatchmakingResultUserDetails(
    filter: FilterQuery<UserGameData>,
  ): Promise<UserGameData[]>;
}
