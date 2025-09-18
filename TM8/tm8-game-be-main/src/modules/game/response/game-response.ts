import { ApiProperty } from '@nestjs/swagger';

import { Game } from 'src/common/constants';

export class GameResponse {
  @ApiProperty()
  display: string;

  @ApiProperty({ enum: Game })
  game: Game;

  @ApiProperty()
  iconKey: string;
}
