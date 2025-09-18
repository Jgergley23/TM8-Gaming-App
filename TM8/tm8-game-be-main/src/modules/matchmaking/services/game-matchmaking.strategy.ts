import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

export interface GameMatchmakingStrategy {
  /**
   * Filters game preferences based on the game strategy
   * @param userGameData - current user game data
   * @param playersGameData - other users game data
   * @returns - array of matching preference user ids arrays
   */
  filterPreferences(
    userGameData: UserGameData,
    playersGameData: UserGameData[],
  ): string[][];
}
