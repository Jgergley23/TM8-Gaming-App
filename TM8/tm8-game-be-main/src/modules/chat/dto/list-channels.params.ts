import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';

export class ListChannelsParams {
  @ApiPropertyOptional()
  @IsString({ message: 'Username must be a string' })
  @IsOptional()
  username?: string;
}
