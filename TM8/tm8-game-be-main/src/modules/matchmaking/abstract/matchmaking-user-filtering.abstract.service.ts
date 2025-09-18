import { Game } from 'src/common/constants';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';
import { User } from 'src/modules/user/schemas/user.schema';

export abstract class AbstractMatchmakingUserFilteringService {
  abstract filterPlayableUserGameData(
    currentUser: User,
    otherPlayers: UserGameData[],
  ): UserGameData[];
  abstract filterUnmatchableUsers(
    currentUser: User,
    userIds: string[],
    game: Game,
  ): Promise<string[]>;
  abstract checkMatchmakingResultsForExistingPotentialMatch(
    userId: string,
    game: string,
    matchmakingResults: string[],
  ): Promise<string[]>;
}
