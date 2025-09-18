import { ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsDateString,
  IsEnum,
  IsMongoId,
  IsNotEmpty,
  IsOptional,
  IsString,
  MaxLength,
} from 'class-validator';

import {
  UserGroup,
  UserNotificationInterval,
  UserNotificationType,
} from 'src/common/constants';
import { IsDateNowOrInFuture } from 'src/common/validation/is-date-now-or-in-future.validator';

export class UpdateScheduledNotificationInput {
  @ApiPropertyOptional()
  @IsString({ message: 'Title must be a string' })
  @MaxLength(30, { message: 'Title must be at most 30 characters long' })
  @IsNotEmpty({ message: 'Title is required' })
  @IsOptional()
  title?: string;

  @ApiPropertyOptional()
  @IsString({ message: 'Description must be a string' })
  @MaxLength(150, {
    message: 'Description must be at most 150 characters long',
  })
  @IsNotEmpty({ message: 'Description is required' })
  @IsOptional()
  description?: string;

  @ApiPropertyOptional()
  @IsString({ message: 'Redirect screen must be a string' })
  @IsOptional()
  redirectScreen?: string;

  @ApiPropertyOptional({ enum: UserNotificationType })
  @IsEnum(UserNotificationType, { message: 'Invalid notification type' })
  @IsOptional()
  notificationType?: UserNotificationType;

  @ApiPropertyOptional()
  @IsMongoId({ message: 'User ID must be valid MongoDB ID' })
  @IsOptional()
  individualUserId?: string;

  @ApiPropertyOptional()
  @IsDateString()
  @IsDateNowOrInFuture({ message: 'Date must be now or in the future' })
  @IsOptional()
  date?: Date;

  @ApiPropertyOptional({ enum: UserNotificationInterval })
  @IsEnum(UserNotificationInterval, {
    message: 'Invalid notification interval',
  })
  @IsOptional()
  interval?: UserNotificationInterval;

  @ApiPropertyOptional({ enum: UserGroup })
  @IsEnum(UserGroup, {
    message: 'Invalid user group',
  })
  @IsOptional()
  targetGroup?: UserGroup;
}
