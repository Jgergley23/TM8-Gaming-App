import { ApiProperty } from '@nestjs/swagger';

import { PaginationMetaResponse } from 'src/common/pagination/pagination-meta.response';

import { ChatChannelResponse } from './chat-channel.response';

export class ChatChannelPaginatedResponse {
  @ApiProperty()
  items: ChatChannelResponse[];

  @ApiProperty()
  meta: PaginationMetaResponse;
}
