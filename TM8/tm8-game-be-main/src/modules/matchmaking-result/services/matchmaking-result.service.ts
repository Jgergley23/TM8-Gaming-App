import { Injectable } from '@nestjs/common';

import { Game } from 'src/common/constants';

import { AbstractMatchmakingResultRepository } from '../abstract/matchmaking-result.abstract.repository';
import { AbstractMatchmakingResultService } from '../abstract/matchmaking-result.service.abstract';

@Injectable()
export class MatchmakingResultService extends AbstractMatchmakingResultService {
  constructor(
    private readonly matchmakingResultRepository: AbstractMatchmakingResultRepository,
  ) {
    super();
  }

  /**
   * Cleans up matchmaking result for a user for a certain game
   * @param userId - user id
   * @param game - game name
   * @returns Void
   */
  async resetMatchmakingResults(userId: string, game: Game): Promise<void> {
    const matchmakingResult =
      await this.matchmakingResultRepository.findOneLean({
        user: userId,
        game,
      });
    if (matchmakingResult) {
      await this.matchmakingResultRepository.updateOneById(
        matchmakingResult._id,
        { matches: [] },
      );
    }
  }

  /**
   * Deletes all matchmaking results where the user is involved
   * @param userId - user id
   * @returns Void
   */
  async deleteUserMatchmakingResults(userId: string): Promise<void> {
    const matchmakingResults =
      await this.matchmakingResultRepository.findManyLean({
        user: userId,
      });
    if (matchmakingResults.length > 0) {
      const matchmakingResultsIds = matchmakingResults.map((match) =>
        match._id.toString(),
      );
      await this.matchmakingResultRepository.deleteMany(matchmakingResultsIds);
    }
  }
}
