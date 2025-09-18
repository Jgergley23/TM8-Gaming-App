import {
  Injectable,
  NotFoundException,
  OnApplicationBootstrap,
} from '@nestjs/common';
import mongoose from 'mongoose';

import { NodeConfig } from 'src/common/config/env.validation';
import { Environment, Role } from 'src/common/constants';
import { Game } from 'src/common/constants/game.enum';
import { AbstractUserGameDataRepository } from 'src/modules/user-game-data/abstract/user-game-data.abstract.repository';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';
import { User } from 'src/modules/user/schemas/user.schema';

import {
  apexLegendsPreferences,
  callOfDutyPreferences,
  fortnitePreferences,
  rocketLeaguePreferences,
} from '../constants/seeder-data';
import { UserGameData } from '../schemas/user-game-data.schema';
import { UserGamePreference } from '../schemas/user-game-preference.schema';

@Injectable()
export class UserGameDataSeederService implements OnApplicationBootstrap {
  constructor(
    private readonly userRepository: AbstractUserRepository,
    private readonly userGameDataRepository: AbstractUserGameDataRepository,
    private readonly nodeConfig: NodeConfig,
  ) {}

  async onApplicationBootstrap(): Promise<void> {
    /**
     * NOTE: Used only in development environment
     */
    if (this.nodeConfig.ENV !== Environment.Production) {
      const gameDataCount = await this.userGameDataRepository.count();
      if (gameDataCount < 1) {
        const users = await this.userRepository.findManyLean({
          role: Role.User,
        });
        if (!users) throw new NotFoundException('Users not found');
        const userGameData = this.populateUserGameData(users);
        await this.createGamePreferences(userGameData);
      }
    }
  }

  /**
   * Seeds user game preferences
   * @param users - Array of users
   * @returns user game data
   */
  populateUserGameData(users: User[]): UserGameData[] {
    const userGameData: UserGameData[] = [];
    for (const user of users) {
      for (const game of Object.values(Game)) {
        const preferences = dataRecord[game];
        userGameData.push({
          _id: String(new mongoose.Types.ObjectId()),
          game,
          user: user._id,
          preferences,
        });
      }
    }
    return userGameData;
  }

  /**
   * Creates a game prefference
   * @param game - Game name
   * @param userId - User ID
   * @param preferences - Array of user preference data
   * @returns Void
   */
  async createGamePreferences(useGameData: UserGameData[]): Promise<void> {
    await this.userGameDataRepository.createMany(useGameData);
  }
}

const dataRecord: Record<Game, UserGamePreference[]> = {
  'rocket-league': rocketLeaguePreferences,
  'apex-legends': apexLegendsPreferences,
  'call-of-duty': callOfDutyPreferences,
  fortnite: fortnitePreferences,
};
