export abstract class AbstractCacheService {
  abstract getClient(): any;

  abstract addToSet(key: string, members: string | string[]): Promise<number>;

  abstract removeFromSet(
    key: string,
    members: string | string[],
  ): Promise<number>;

  abstract readSet(key: string): Promise<string[]>;

  abstract deleteKey(key: string): Promise<number>;
}
