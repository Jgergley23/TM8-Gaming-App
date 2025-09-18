import { DefaultGenerics, QueryChannelAPIResponse } from 'stream-chat';

import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { ListChannelsParams } from 'src/modules/chat/dto/list-channels.params';
import { ChatChannelResponse } from 'src/modules/chat/response/chat-channel.response';
import { ChatResponse } from 'src/modules/chat/response/chat.response';
import { ChatUpsertUserInput } from 'src/modules/chat/types/chat-upsert-user.input';

import { CreateStreamChannel } from '../types/create-stream-channel.type';

export interface IChatProviderChatService {
  createChannel(
    channelData: CreateStreamChannel,
  ): Promise<ChatResponse<QueryChannelAPIResponse<DefaultGenerics>>>;
  listUserChannels(
    userId: string,
    listChannelParams: ListChannelsParams,
    params: PaginationParams,
  ): Promise<PaginationModel<ChatChannelResponse>>;
  deleteChannelsContainingMembers(memberIds: string[]): Promise<void>;
}

export interface IChatProviderUserService {
  createChatUserToken(userId: string): Promise<ChatResponse<string>>;
  upsertUser(input: ChatUpsertUserInput): Promise<ChatResponse<null>>;
}

export const ChatProviderChatServiceToken = Symbol('ChatProviderChatService');
export const ChatProviderUserServiceToken = Symbol('ChatProviderUserService');

export const ChatProviderToken = Symbol('ChatProvider');
