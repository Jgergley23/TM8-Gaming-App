import { Inject, LoggerService } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER } from 'nest-winston';

import { REDIS_ONLINE_PRESENCE_SET_NAME } from 'src/common/constants/redis';
import { AbstractCacheService } from 'src/modules/redis/abstract';

import { AbstractOnlinePresenceService } from '../abstract/online-presence.abstract.service';

export class OnlinePresenceService extends AbstractOnlinePresenceService {
  constructor(
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: LoggerService,
    private readonly cacheService: AbstractCacheService,
  ) {
    super();
  }

  /**
   * Filters the list of user IDs to get only the online users
   * @param userIds - the list of user IDs to check
   * @returns a list of user IDs that are online
   */
  async filterOnlineUsers(userIds: string[]): Promise<string[]> {
    try {
      // Get the Redis set of online users
      const onlineUserIds = await this.cacheService.readSet(
        REDIS_ONLINE_PRESENCE_SET_NAME,
      );
      // Filter the list of user IDs to get only the online users
      return userIds.filter((userId) =>
        onlineUserIds.includes(userId.toString()),
      );
    } catch (error) {
      this.logger.error(`Error checking online users - ${error}`);
      return [];
    }
  }
}
