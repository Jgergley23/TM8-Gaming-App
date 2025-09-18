import { Game } from 'src/common/constants';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';

import { MatchmakingResultUserResponse } from '../response/matchmaking-result-user.response';

export abstract class AbstractMatchmakingService {
  abstract matchmake(userId: string, game: Game): Promise<void>;
  abstract listMatchmakingResults(
    userId: string,
    game: Game,
    params: PaginationParams,
  ): Promise<PaginationModel<MatchmakingResultUserResponse>>;
}
