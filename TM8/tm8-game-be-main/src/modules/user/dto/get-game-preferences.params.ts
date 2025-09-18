import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsOptional, IsString } from 'class-validator';

import { Game } from 'src/common/constants';
import { IsEnumArray } from 'src/common/validation/is-enum-array.validator';

export class GetGamePreferencesParams {
  @ApiPropertyOptional({
    description: 'Game parameters',
    type: String,
  })
  @Type(() => String)
  @IsString({ message: 'Game parameters must be string' })
  @IsEnumArray(Game, { message: 'Provide valid game input' })
  @IsOptional()
  games?: string;
}
