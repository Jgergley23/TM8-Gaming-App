import { Module } from '@nestjs/common';

import { AbstractCacheService } from './abstract';
import { RedisProvider } from './providers';
import { RedisService } from './services';

@Module({
  providers: [
    RedisProvider,
    RedisService,
    { provide: AbstractCacheService, useExisting: RedisService },
  ],
  exports: [AbstractCacheService],
})
export class RedisModule {}
