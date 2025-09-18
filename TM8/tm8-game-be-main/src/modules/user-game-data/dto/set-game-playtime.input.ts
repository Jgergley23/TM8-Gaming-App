import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsNotEmpty } from 'class-validator';

import { Playtime } from 'src/common/constants';

export class SetGamePlaytimeInput {
  @ApiProperty()
  @IsEnum(Playtime, {
    message: `Please provide one of the values: ${Object.values(Playtime)}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  playtime: string;
}
