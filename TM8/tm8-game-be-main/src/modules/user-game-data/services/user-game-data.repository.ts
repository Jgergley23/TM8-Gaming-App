import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { FilterQuery, Model } from 'mongoose';

import { IAggregatedGameUsersCount } from 'src/modules/statistics/interfaces/aggregated-game-users-count.interface';

import { AbstractUserGameDataRepository } from '../abstract/user-game-data.abstract.repository';
import { UserGameData } from '../schemas/user-game-data.schema';

@Injectable()
export class UserGameDataRepository extends AbstractUserGameDataRepository {
  constructor(
    @InjectModel('UserGameData')
    repository: Model<UserGameData>,
  ) {
    super(repository);
  }
  /**
   * Counts users per game
   */
  public async countUsersPerGame(
    requiredGroups: string[],
  ): Promise<IAggregatedGameUsersCount[]> {
    return await this.entity.aggregate([
      {
        $group: {
          _id: '$game',
          count: { $sum: 1 },
        },
      },
      {
        $match: {
          _id: { $in: requiredGroups },
        },
      },
    ]);
  }

  /**
   * Gets user game data with populated user ids and notification tokens
   * @param filter - filter query
   * @returns array of user game data
   */
  async getUserGameDataWithUsers(
    filter: FilterQuery<UserGameData> = {},
  ): Promise<UserGameData[]> {
    return await this.entity
      .find(filter)
      .populate({
        path: 'user',
        select: '_id notificationToken notificationSettings',
      })
      .lean();
  }

  /**
   * Gets user game data with populated user info needed for matchmaking
   * @param filter - filter query
   * @returns array of user game data
   */
  async getUserGameDataWithUserMatchmakingData(
    filter: FilterQuery<UserGameData> = {},
  ): Promise<UserGameData[]> {
    return await this.entity
      .find(filter)
      .populate({
        path: 'user',
        select: '_id status dateOfBirth regions rejectedUsers',
      })
      .lean();
  }

  /**
   * Gets user game data with populated user info needed for displaying matchmaking result details
   * @param filter - filter query
   * @returns array of user game data
   */
  async getUserGameDataWithMatchmakingResultUserDetails(
    filter: FilterQuery<UserGameData> = {},
  ): Promise<UserGameData[]> {
    return await this.entity
      .find(filter)
      .populate({
        path: 'user',
        select: '_id photoKey audioKey dateOfBirth country username',
      })
      .lean();
  }
}
