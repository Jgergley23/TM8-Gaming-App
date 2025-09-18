import { Provider } from '@nestjs/common';
import { createClient } from 'redis';

import { AppConfig, RedisConfig } from 'src/common/config/env.validation';

export const RedisProvider: Provider = {
  useFactory: async (appConfig: AppConfig, redisConfig: RedisConfig) => {
    const prefix =
      appConfig.NODE.ENV === 'production' ? 'rediss://' : 'redis://';
    const url = `${prefix}${redisConfig.URL}`;
    const client = createClient({
      url,
    });
    await client.connect();
    return client;
  },
  provide: 'REDISDB',
  inject: [AppConfig, RedisConfig],
};
