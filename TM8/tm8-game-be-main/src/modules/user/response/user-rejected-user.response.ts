import { ApiProperty } from '@nestjs/swagger';

import { Game } from 'src/common/constants';

export class UserRejectedUserResponse {
  @ApiProperty()
  user: string;

  @ApiProperty()
  until: Date;

  @ApiProperty({ enum: Game })
  game: Game;
}
