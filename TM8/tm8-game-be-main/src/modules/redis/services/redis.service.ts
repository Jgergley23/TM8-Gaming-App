import { Inject, Injectable } from '@nestjs/common';
import {
  RedisClientType,
  RedisFunctions,
  RedisModules,
  RedisScripts,
} from 'redis';

import { AbstractCacheService } from '../abstract';

@Injectable()
export class RedisService extends AbstractCacheService {
  constructor(
    @Inject('REDISDB')
    private readonly redisConnection: RedisClientType<
      RedisModules,
      RedisFunctions,
      RedisScripts
    >,
  ) {
    super();
  }

  /**
   * @description Get redis client
   * @returns redis client
   */
  getClient(): RedisClientType<RedisModules, RedisFunctions, RedisScripts> {
    return this.redisConnection;
  }

  /**
   * @description add string or array of strings to set in redis db under key
   * @param key
   * @param members
   * @returns number of elements added to set
   */
  addToSet(key: string, members: string | string[]): Promise<number> {
    return this.redisConnection.sAdd(key, members);
  }

  /**
   * @description remove string or array of strings from set in redis db under key
   * @param key
   * @param members
   * @returns number of elements removed from set
   */
  removeFromSet(key: string, members: string | string[]): Promise<number> {
    return this.redisConnection.sRem(key, members);
  }

  /**
   * @description read set with key
   * @param key
   * @returns array of strings stored in set
   */
  readSet(key: string): Promise<string[]> {
    return this.redisConnection.sMembers(key);
  }

  /**
   * @description delete values set under key from redis db
   * @param key
   * @returns number of keys that were removed
   */
  deleteKey(key: string): Promise<number> {
    return this.redisConnection.del(key);
  }
}
