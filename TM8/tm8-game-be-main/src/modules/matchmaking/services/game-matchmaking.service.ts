import { Injectable } from '@nestjs/common';

import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { AbstractGameMatchmakingService } from '../abstract/game-matchmaking.abstract.service';
import { GameMatchmakingStrategy } from './game-matchmaking.strategy';

@Injectable()
export class GameMatchmakingService extends AbstractGameMatchmakingService {
  private strategy: GameMatchmakingStrategy;

  setStrategy(strategy: GameMatchmakingStrategy): void {
    this.strategy = strategy;
  }

  filterPreferences(
    userGameData: UserGameData,
    playersGameData: UserGameData[],
  ): string[][] {
    return this.strategy.filterPreferences(userGameData, playersGameData);
  }
}
