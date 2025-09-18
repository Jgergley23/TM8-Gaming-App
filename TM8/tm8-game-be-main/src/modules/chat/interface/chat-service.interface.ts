import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { CreateStreamChannel } from 'src/modules/stream-chat/types/create-stream-channel.type';

import { ListChannelsParams } from '../dto/list-channels.params';
import { ChatChannelResponse } from '../response/chat-channel.response';
import { ChatResponse } from '../response/chat.response';
import { CreateChannelResponse } from '../response/create-channel.response';
import { ChatUpsertUserInput } from '../types/chat-upsert-user.input';

export enum ChatServiceResult {
  SUCCESS,
  FAIL,
}

export interface IChatChatService {
  createChannel(
    channelData: CreateStreamChannel,
  ): Promise<CreateChannelResponse>;
  listUserChannels(
    userId: string,
    listChannelParams: ListChannelsParams,
    params: PaginationParams,
  ): Promise<PaginationModel<ChatChannelResponse>>;
  deleteUserChannels(userId: string): Promise<void>;
}

export interface IChatUserService {
  createChatUserToken(userId: string): Promise<ChatResponse<string>>;
  upsertUser(input: ChatUpsertUserInput): Promise<ChatResponse<null>>;
  refreshUserToken(userId: string): Promise<ChatResponse<string>>;
}

export const ChatChatServiceToken = Symbol('ChatChatServiceToken');
export const ChatUserServiceToken = Symbol('ChatUserServiceToken');
