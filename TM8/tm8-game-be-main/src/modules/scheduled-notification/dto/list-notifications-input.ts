import { ApiPropertyOptional } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsEnum, IsOptional, IsString } from 'class-validator';

import { UserGroup, UserNotificationType } from 'src/common/constants';

export class ListNotificationsInput {
  @ApiPropertyOptional({
    description: 'Sorting parameters',
    type: String,
  })
  @IsString({ message: 'Sorting parameters must be in string format' })
  @IsOptional()
  sort = '-date';

  @ApiPropertyOptional({
    description: 'Title filter',
    type: String,
  })
  @IsString({ message: 'Title search parameter must be in string format' })
  @IsOptional()
  title = '';

  @ApiPropertyOptional({
    description: 'User group filter',
    type: String,
    nullable: true,
  })
  @Transform(({ value }) => value.split(',').map((group) => group.trim()))
  @IsEnum(UserGroup, {
    each: true,
    message: 'Input must be one of user groups',
  })
  @IsOptional()
  userGroups?: string;

  @ApiPropertyOptional({
    description: 'Notification type filter',
    type: String,
    nullable: true,
  })
  @Transform(({ value }) => value.split(',').map((group) => group.trim()))
  @IsEnum(UserNotificationType, {
    each: true,
    message: 'Input must be one of notification types',
  })
  @IsOptional()
  types?: string;
}
