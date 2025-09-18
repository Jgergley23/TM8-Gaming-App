import { Inject, LoggerService } from '@nestjs/common';
import {
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import * as jwt from 'jsonwebtoken';
import { WINSTON_MODULE_NEST_PROVIDER } from 'nest-winston';
import { Server, Socket } from 'socket.io';

import { JwtConfig } from 'src/common/config/env.validation';
import { REDIS_ONLINE_PRESENCE_SET_NAME } from 'src/common/constants/redis';
import { TGMDUnauthorizedException } from 'src/common/exceptions/custom.exception';
import { AbstractCacheService } from 'src/modules/redis/abstract';

type TokenPayload = {
  sub: string;
  username: string;
};

@WebSocketGateway({
  cors: {
    origin: '*',
  },
  transports: ['websocket'],
})
export class OnlinePresenceGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer()
  server: Server;

  constructor(
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: LoggerService,
    private readonly jwtConfig: JwtConfig,
    private readonly cacheService: AbstractCacheService,
  ) {}

  /**
   * Adds a middleware to check for the authorization token (Called when the gateway is initialized)
   * @param server - the IO server instance
   */
  afterInit(server: Server): void {
    // Register a middleware to check for the authorization token
    server.use((socket, next) => {
      // Check if there is an authorization token present
      const tokenHeader = socket.handshake.headers.authorization;
      if (!tokenHeader || !tokenHeader.includes('Bearer')) {
        return next(new TGMDUnauthorizedException('Bearer token not provided'));
      }
      next();
    });
  }

  /**
   * Removes the user ID from the Redis set of online users (Called when a gateway connection is disconnected)
   * @param socket - the socket instance
   * @returns void
   */
  async handleDisconnect(socket: Socket): Promise<void> {
    // Remove the user ID from the Redis set of online users
    if (socket.data.userId) {
      try {
        await this.cacheService.removeFromSet(
          REDIS_ONLINE_PRESENCE_SET_NAME,
          socket.data.userId,
        );
      } catch (error) {
        this.logger.error(`Error while disconnecting a web socket - ${error}`);
      }
    }
  }

  /**
   * Verifies the JWT token and adds the user ID to the socket (Called when a new gateway connection is established)
   * @param socket - the socket instance
   * @returns void
   */
  async handleConnection(socket: Socket): Promise<void> {
    // Extract the authorizati header from the socket
    const tokenHeader = socket.handshake.headers.authorization;

    // Extract the token from the header
    const token = tokenHeader.split(' ')[1].trim();
    try {
      // Verify the JWT token
      const payload = jwt.verify(token, this.jwtConfig.SECRET) as TokenPayload;

      // Add the user ID to the socket
      socket.data.userId = payload.sub;

      // Add the user ID to the Redis set of online users
      await this.cacheService.addToSet(
        REDIS_ONLINE_PRESENCE_SET_NAME,
        payload.sub,
      );
    } catch (error) {
      // Log the error and disconnect the socket
      this.logger.error(`Error while connecting a web socket - ${error}`);
      socket.disconnect();
    }
  }
}
