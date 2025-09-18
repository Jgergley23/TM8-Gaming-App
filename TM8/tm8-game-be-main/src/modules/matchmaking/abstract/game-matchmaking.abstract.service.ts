import { Injectable } from '@nestjs/common';

import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { GameMatchmakingStrategy } from '../services/game-matchmaking.strategy';

@Injectable()
export abstract class AbstractGameMatchmakingService {
  abstract filterPreferences(
    userGameData: UserGameData,
    playersGameData: UserGameData[],
  ): string[][];
  abstract setStrategy(strategy: GameMatchmakingStrategy): void;
}
