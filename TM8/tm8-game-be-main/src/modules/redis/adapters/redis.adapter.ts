import { INestApplication } from '@nestjs/common';
import { IoAdapter } from '@nestjs/platform-socket.io';
import { createAdapter } from '@socket.io/redis-adapter';
import { createClient } from 'redis';
import { ServerOptions } from 'socket.io';

import { RootConfig } from 'src/common/config/env.validation';

export class RedisIoAdapter extends IoAdapter {
  private adapterConstructor: ReturnType<typeof createAdapter>;

  constructor(
    private readonly app: INestApplication,
    private readonly config: RootConfig,
  ) {
    super(app);
  }

  /**
   * Connects to a redis cluster
   * @param void
   * @returns void
   */
  async connectToRedis(): Promise<void> {
    // Compose the Redis URL
    const urlPrefix =
      this.config.APP.NODE.ENV === 'production' ? 'rediss://' : 'redis://';
    const url = `${urlPrefix}${this.config.REDIS.URL}`;

    // Create the Redis clients
    const pubClient = createClient({
      url: url,
    });
    const subClient = pubClient.duplicate();

    // Connect to the Redis clients
    await Promise.all([pubClient.connect(), subClient.connect()]);

    // Create the adapter constructor
    this.adapterConstructor = createAdapter(pubClient, subClient);
  }

  /**
   * Creates a new instance of the RedisIoAdapter
   * @param port - the port to listen on
   * @param options - the options to pass to the server
   * @returns any
   */
  createIOServer(port: number, options?: ServerOptions): any {
    const server = super.createIOServer(port, options);
    server.adapter(this.adapterConstructor);
    return server;
  }
}
