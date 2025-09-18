import { Inject, Injectable } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';
import { StreamChat } from 'stream-chat';

import { StreamChatConfig } from 'src/common/config/env.validation';
import { NumberUtils } from 'src/common/utils/number.utils';
import { ChatServiceResult } from 'src/modules/chat/interface/chat-service.interface';
import { ChatResponse } from 'src/modules/chat/response/chat.response';
import { ChatUpsertUserInput } from 'src/modules/chat/types/chat-upsert-user.input';

import {
  ChatProviderToken,
  IChatProviderUserService,
} from '../interface/chat-provider.interface';

@Injectable()
export class StreamChatUserService implements IChatProviderUserService {
  constructor(
    @Inject(ChatProviderToken)
    private readonly streamChat: StreamChat,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
    private readonly streamConfig: StreamChatConfig,
  ) {}

  /**
   * Create getstream token with expiry date for existing getstream user
   * @param userId - string
   * @returns chat token response
   */
  async createChatUserToken(userId: string): Promise<ChatResponse<string>> {
    try {
      const streamToken = this.streamChat.createToken(
        userId,
        NumberUtils.makeExpiryDate(this.streamConfig.TOKENEXPHRS),
        NumberUtils.issuedAtTime(),
      );
      return { data: streamToken, status: ChatServiceResult.SUCCESS };
    } catch (err) {
      this.logger.error(err);
      return {
        status: ChatServiceResult.FAIL,
        data: null,
        error: err.message,
      };
    }
  }

  /**
   * Upsert user to getstream
   * @param input - upsert user input
   * @returns chat response without data
   */
  async upsertUser(input: ChatUpsertUserInput): Promise<ChatResponse<null>> {
    try {
      await this.streamChat.upsertUser(input);
      return { data: null, status: ChatServiceResult.SUCCESS };
    } catch (err) {
      this.logger.error(err);
      return {
        status: ChatServiceResult.FAIL,
        data: null,
        error: err.message,
      };
    }
  }
}
