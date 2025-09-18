import { ApiProperty } from '@nestjs/swagger';

export class CheckFriendshipResponse {
  @ApiProperty()
  isFriend: boolean;
}
