import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ChatChattingWithResponse {
  @ApiProperty()
  id: string;

  @ApiProperty()
  username: string;

  @ApiProperty()
  online: boolean;

  @ApiPropertyOptional()
  avatar?: string;
}

export class ChatChannelResponse {
  @ApiProperty()
  id: string;

  @ApiProperty({ type: ChatChattingWithResponse })
  chattingWith: ChatChattingWithResponse;

  @ApiProperty()
  lastMessage: string;
}
