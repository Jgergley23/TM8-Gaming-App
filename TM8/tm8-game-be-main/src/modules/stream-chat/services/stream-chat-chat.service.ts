import { Inject, Injectable } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';
import {
  ChannelSortBase,
  DefaultGenerics,
  QueryChannelAPIResponse,
  StreamChat,
} from 'stream-chat';

import { ActionType, ChatChannelType } from 'src/common/constants';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { AbstractActionRepository } from 'src/modules/action/abstract/action.abstract.repository';
import { ListChannelsParams } from 'src/modules/chat/dto/list-channels.params';
import { ChatServiceResult } from 'src/modules/chat/interface/chat-service.interface';
import { ChatChannelResponse } from 'src/modules/chat/response/chat-channel.response';
import { ChatResponse } from 'src/modules/chat/response/chat.response';

import {
  ChatProviderToken,
  IChatProviderChatService,
} from '../interface/chat-provider.interface';
import { CreateStreamChannel } from '../types/create-stream-channel.type';

@Injectable()
export class StreamChatChatService implements IChatProviderChatService {
  constructor(
    @Inject(ChatProviderToken)
    private readonly streamChat: StreamChat,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
    private readonly actionRepository: AbstractActionRepository,
  ) {}

  /**
   * Creates a Stream chat channel
   * @param channelData - channel input data
   * @returns channel api response
   */
  async createChannel(
    channelData: CreateStreamChannel,
  ): Promise<ChatResponse<QueryChannelAPIResponse<DefaultGenerics>>> {
    try {
      const channel = this.streamChat.channel(ChatChannelType.Dm, {
        name: channelData?.name,
        isDeleted: false,
        members: channelData.members,
        created_by_id: channelData.owner,
      });

      const result = await channel.create();
      return { data: result, status: ChatServiceResult.SUCCESS };
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
   * Fetches a list of channels for a user
   * @param userId - user Id
   * @param params - pagination params
   * @returns channel list response
   */
  async listUserChannels(
    userId: string,
    listChannelsParams: ListChannelsParams,
    params: PaginationParams,
  ): Promise<PaginationModel<ChatChannelResponse>> {
    const { username } = listChannelsParams;
    const { limit, skip } = params;
    const filter = {
      type: 'dm',
      members: {
        $in: [userId],
      },
    };

    const sort: ChannelSortBase<DefaultGenerics>[] = [{ last_message_at: -1 }];

    const userBlocks = await this.actionRepository.findOneLean({
      user: userId,
      actionType: ActionType.Block,
    });

    const channels = await this.streamChat.queryChannels(filter, sort, {
      watch: false,
      limit,
      offset: skip,
    });

    const count = (await this.streamChat.queryChannels(filter)).length;

    let result = await Promise.all(
      channels.map(async (channel) => {
        const chattingWithUserKey = Object.keys(channel.state.members).filter(
          (member) => member !== userId,
        )[0];

        const chattingWithUser =
          channel.state.members[chattingWithUserKey].user;

        const isBlocked =
          userBlocks?.actionsTo.some(
            (f) => f.user.toString() === chattingWithUser.id,
          ) ||
          userBlocks?.actionsFrom.some(
            (f) => f.user.toString() === chattingWithUser.id,
          );

        return {
          id: channel.id,
          chattingWith: {
            id: chattingWithUser.id,
            username: isBlocked
              ? 'Unavailable user'
              : chattingWithUser.username,
            online: isBlocked ? false : chattingWithUser.online,
            avatar: isBlocked ? null : (chattingWithUser?.image as string),
          },
          lastMessage: channel?.lastMessage()
            ? channel?.lastMessage().text
            : 'No messages',
        };
      }),
    );

    if (username) {
      const regex = new RegExp(username, 'i');

      result = result.filter((channel) =>
        regex.test(channel.chattingWith.username),
      );
    }
    return new PaginationModel(result, params, count);
  }

  /**
   * Deletes channels containing the members
   * @param memberIds - member ids
   */
  async deleteChannelsContainingMembers(memberIds: string[]): Promise<void> {
    // Filter channels that contain the specified members
    const channelFilter = {
      type: ChatChannelType.Dm,
      members: {
        $in: memberIds,
      },
    };
    const channels = await this.streamChat.queryChannels(channelFilter);

    // Delete the channels
    const results = await Promise.allSettled(
      channels.map((channel) => {
        return channel.delete();
      }),
    );

    // Filter out rejected promises and log the reasons (if any)
    const isRejected = <T>(
      p: PromiseSettledResult<T>,
    ): p is PromiseRejectedResult => p.status === 'rejected';
    const rejectedResults = results.filter(isRejected);
    rejectedResults.forEach((rejectedResult) => {
      this.logger.error(
        `Error while deleting a channel - `,
        rejectedResult.reason,
      );
    });
  }
}
