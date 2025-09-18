import { ApiProperty } from '@nestjs/swagger';

export class ChatRefreshTokenResponse {
  @ApiProperty()
  chatToken: string;
}
