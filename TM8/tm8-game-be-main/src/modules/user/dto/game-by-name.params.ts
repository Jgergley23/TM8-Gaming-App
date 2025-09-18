import { ApiProperty } from '@nestjs/swagger';
import { IsEnum } from 'class-validator';

import { Game } from 'src/common/constants';

export class GetGameByNameParams {
  @ApiProperty({
    name: 'game',
    description: 'Game name',
    type: String,
  })
  @IsEnum(Game, { message: 'Please provide a valid game input' })
  game: Game;
}
