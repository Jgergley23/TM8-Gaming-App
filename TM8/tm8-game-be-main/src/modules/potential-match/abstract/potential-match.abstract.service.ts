import { Game } from 'src/common/constants';
import { AcceptPotentialMatchResponse } from 'src/modules/potential-match/response/accept-potential-match.response';

export abstract class AbstractPotentialMatchService {
  abstract resetUserPotentialMatches(userId: string, game: Game): Promise<void>;
  abstract acceptPotentialMatch(
    currentUserId: string,
    targetUserId: string,
    game: Game,
  ): Promise<AcceptPotentialMatchResponse>;
  abstract rejectPotentialMatch(
    currentUserId: string,
    targetUserId: string,
    game: Game,
  ): Promise<void>;
  abstract deleteUserPotentialMatches(userId: string): Promise<void>;
}
