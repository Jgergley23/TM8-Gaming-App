import { Inject, Injectable } from '@nestjs/common';

import { TGMDExternalServiceException } from 'src/common/exceptions/custom.exception';
import {
  ChatProviderUserServiceToken,
  IChatProviderUserService,
} from 'src/modules/stream-chat/interface/chat-provider.interface';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import {
  ChatServiceResult,
  IChatUserService,
} from '../interface/chat-service.interface';
import { ChatResponse } from '../response/chat.response';
import { ChatUpsertUserInput } from '../types/chat-upsert-user.input';

@Injectable()
export class ChatUserService implements IChatUserService {
  constructor(
    @Inject(ChatProviderUserServiceToken)
    private readonly chatUserProvider: IChatProviderUserService,
    private readonly userRespository: AbstractUserRepository,
  ) {}

  /**
   * Create getstream token with expiry date for existing getstream user
   * @param userId - string
   * @returns chat token response
   */
  async createChatUserToken(userId: string): Promise<ChatResponse<string>> {
    const result = await this.chatUserProvider.createChatUserToken(userId);
    if (result.status !== ChatServiceResult.SUCCESS)
      throw new TGMDExternalServiceException('Failed to create chat token');
    return result;
  }

  /**
   * Upsert user to getstream
   * @param input - upsert user input
   * @returns chat response without data
   */
  async upsertUser(input: ChatUpsertUserInput): Promise<ChatResponse<null>> {
    const result = await this.chatUserProvider.upsertUser(input);
    if (result.status !== ChatServiceResult.SUCCESS)
      throw new TGMDExternalServiceException('Failed to create chat token');
    return result;
  }

  /**
   * Create token for user and save it to user in the database
   * @param userId - user id
   * @returns chat token response
   */
  async refreshUserToken(userId: string): Promise<ChatResponse<string>> {
    const result = await this.chatUserProvider.createChatUserToken(userId);
    if (result.status !== ChatServiceResult.SUCCESS)
      throw new TGMDExternalServiceException('Failed to refresh');

    await this.userRespository.updateOneById(userId, {
      chatToken: result.data,
    });

    return result;
  }
}
