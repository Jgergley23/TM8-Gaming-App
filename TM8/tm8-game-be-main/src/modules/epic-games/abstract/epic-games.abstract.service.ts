import { Injectable } from '@nestjs/common';

import { EpicGamesTokenResponse } from 'src/modules/epic-games/response/epic-games-token.response';
import { EpicGamesUserResponse } from 'src/modules/epic-games/response/epic-games-user.response';
import { User } from 'src/modules/user/schemas/user.schema';

@Injectable()
export abstract class AbstractEpicGamesService {
  abstract sendEpicTokenRequest(code: string): Promise<EpicGamesTokenResponse>;
  abstract getEpicGamesUser(
    accessToken: string,
    accountId: string,
  ): Promise<EpicGamesUserResponse>;
  abstract storeEpicData(
    userId: string,
    epicUser: EpicGamesUserResponse,
  ): Promise<User>;
  abstract removeEpicAccount(userId: string): Promise<void>;
}
