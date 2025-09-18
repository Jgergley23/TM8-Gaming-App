import { Module } from '@nestjs/common';

import { RedisModule } from '../redis/redis.module';
import { AbstractOnlinePresenceService } from './abstract';
import { OnlinePresenceGateway } from './gateways';
import { OnlinePresenceService } from './services';

@Module({
  imports: [RedisModule],
  providers: [
    OnlinePresenceGateway,
    OnlinePresenceService,
    {
      provide: AbstractOnlinePresenceService,
      useExisting: OnlinePresenceService,
    },
  ],
  exports: [AbstractOnlinePresenceService],
})
export class OnlinePresenceModule {}
