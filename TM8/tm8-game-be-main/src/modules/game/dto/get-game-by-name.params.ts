import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsNotEmpty } from 'class-validator';

import { Game } from 'src/common/constants';

export class GetGameByNameParams {
  @ApiProperty({
    name: 'game',
    description: 'Game name',
    type: String,
  })
  @IsEnum(Game, {
    message: `Please provide a valid game value, must be one of ${Object.values(
      Game,
    )}`,
  })
  @IsNotEmpty({ message: 'Please provide a game input' })
  game: string;
}
