import {
  Body,
  Controller,
  Get,
  Inject,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common';
import { ApiOkResponse, ApiResponse, ApiTags } from '@nestjs/swagger';

import { Role } from 'src/common/constants';
import {
  CurrentUser,
  IUserTokenData,
} from 'src/common/decorators/current-user.decorator';
import { Roles } from 'src/common/decorators/roles.decorator';
import { TGMDExceptionResponse } from 'src/common/exceptions/custom-exception.response';
import { AccessTokenGuard } from 'src/common/guards/access-token.guard';
import { RolesGuard } from 'src/common/guards/roles.guard';
import { UserStatusGuard } from 'src/common/guards/user-status-guard';
import { PaginationParams } from 'src/common/pagination/pagination-params';

import { CreateChannelInput } from './dto/create-channel.input';
import { ListChannelsParams } from './dto/list-channels.params';
import {
  ChatChatServiceToken,
  ChatUserServiceToken,
  IChatChatService,
  IChatUserService,
} from './interface/chat-service.interface';
import { ChatChannelPaginatedResponse } from './response/chat-channel-paginated.response';
import { ChatRefreshTokenResponse } from './response/chat-refresh-token.response';
import { CreateChannelResponse } from './response/create-channel.response';

@ApiTags('Chats')
@Controller('chat')
@ApiResponse({
  description: 'Non-2XX response',
  type: TGMDExceptionResponse,
})
@UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
export class ChatController {
  constructor(
    @Inject(ChatChatServiceToken)
    private readonly chatChatService: IChatChatService,
    @Inject(ChatUserServiceToken)
    private readonly chatUserService: IChatUserService,
  ) {}

  @Post('channel')
  @ApiResponse({
    status: 201,
    description: 'OK response',
    type: CreateChannelResponse,
  })
  @Roles(Role.User)
  createChannel(
    @Body() createChannelInput: CreateChannelInput,
    @CurrentUser() user: IUserTokenData,
  ): Promise<CreateChannelResponse> {
    createChannelInput.owner = user.sub;
    return this.chatChatService.createChannel(createChannelInput);
  }

  @Get('user/channels')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: ChatChannelPaginatedResponse,
  })
  @Roles(Role.User)
  listUsers(
    @Query() paginationParams: PaginationParams,
    @Query() listChannelsParams: ListChannelsParams,
    @CurrentUser() user: IUserTokenData,
  ) {
    return this.chatChatService.listUserChannels(
      user.sub,
      listChannelsParams,
      paginationParams,
    );
  }

  @Post('token/refresh')
  @ApiResponse({
    status: 200,
    description: 'OK response',
    type: ChatRefreshTokenResponse,
  })
  @Roles(Role.User)
  async refreshChatToken(
    @CurrentUser() user: IUserTokenData,
  ): Promise<ChatRefreshTokenResponse> {
    const result = await this.chatUserService.refreshUserToken(user.sub);
    return { chatToken: result.data };
  }
}
