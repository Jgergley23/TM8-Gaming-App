import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsOptional, IsString } from 'class-validator';

export class ListUserFriendsParams {
  @ApiPropertyOptional({
    description: 'Username filter',
    type: String,
  })
  @Type(() => String)
  @IsString({ message: 'Username search parameter must be in string format' })
  @IsOptional()
  username?: string;
}
