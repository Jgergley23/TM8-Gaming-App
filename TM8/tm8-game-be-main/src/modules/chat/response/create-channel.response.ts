import { ApiProperty } from '@nestjs/swagger';

export class CreateChannelResponse {
  @ApiProperty()
  id: string;
}
