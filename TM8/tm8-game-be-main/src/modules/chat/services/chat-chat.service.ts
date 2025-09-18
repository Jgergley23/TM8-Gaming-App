import { Inject, Injectable } from '@nestjs/common';

import { TGMDExternalServiceException } from 'src/common/exceptions/custom.exception';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import {
  ChatProviderChatServiceToken,
  IChatProviderChatService,
} from 'src/modules/stream-chat/interface/chat-provider.interface';
import { CreateStreamChannel } from 'src/modules/stream-chat/types/create-stream-channel.type';

import { ListChannelsParams } from '../dto/list-channels.params';
import {
  ChatServiceResult,
  IChatChatService,
} from '../interface/chat-service.interface';
import { ChatChannelResponse } from '../response/chat-channel.response';
import { CreateChannelResponse } from '../response/create-channel.response';

@Injectable()
export class ChatChatService implements IChatChatService {
  constructor(
    @Inject(ChatProviderChatServiceToken)
    private readonly chatChatProvider: IChatProviderChatService,
  ) {}

  /**
   * Creates a Stream chat channel
   * @param channelData - channel input data
   * @returns create channel response
   */
  async createChannel(
    channelData: CreateStreamChannel,
  ): Promise<CreateChannelResponse> {
    const data = await this.chatChatProvider.createChannel(channelData);
    if (data.status !== ChatServiceResult.SUCCESS) {
      throw new TGMDExternalServiceException('Stream channel creation failed');
    }
    return { id: data.data.channel.id };
  }

  /**
   * Fetches a list of channels for a user
   * @param userId - user Id
   * @param params - pagination params
   * @returns channel list response
   */
  async listUserChannels(
    userId: string,
    listChannelParams: ListChannelsParams,
    params: PaginationParams,
  ): Promise<PaginationModel<ChatChannelResponse>> {
    return await this.chatChatProvider.listUserChannels(
      userId,
      listChannelParams,
      params,
    );
  }

  /**
   * Deletes all channels containing the user
   * @param userId - user id
   */
  async deleteUserChannels(userId: string): Promise<void> {
    await this.chatChatProvider.deleteChannelsContainingMembers([userId]);
  }
}
