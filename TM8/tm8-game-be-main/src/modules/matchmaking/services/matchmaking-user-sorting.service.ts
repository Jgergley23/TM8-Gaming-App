import { Injectable } from '@nestjs/common';

import { AbstractOnlinePresenceService } from 'src/modules/online-presence/abstract';

import { AbstractMatchmakingUserSortingService } from '../abstract/matchmaking-user-sorting.abstract.service';

@Injectable()
export class MatchmakingUserSortingService extends AbstractMatchmakingUserSortingService {
  constructor(
    private readonly onlinePresenceService: AbstractOnlinePresenceService,
  ) {
    super();
  }

  /**
   * Sorts matchmaking results by online status - online users first
   * @param matchmakingResults - array of user ids
   * @returns - array of user ids sorted by online status
   */
  async sortMatchmakingResultsByOnlineStatus(
    matchmakingResults: string[],
  ): Promise<string[]> {
    // Get the IDs of online users
    const onlineUserIds = await this.onlinePresenceService.filterOnlineUsers(
      matchmakingResults,
    );
    // Put online users first in the matchmaking results
    return onlineUserIds.concat(
      matchmakingResults.filter((id) => !onlineUserIds.includes(id)),
    );
  }
}
