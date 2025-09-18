import { Game } from 'src/common/constants';

export abstract class AbstractMatchmakingResultService {
  abstract resetMatchmakingResults(userId: string, game: Game): Promise<void>;
  abstract deleteUserMatchmakingResults(userId: string): Promise<void>;
}
