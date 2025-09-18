import { ApiProperty } from '@nestjs/swagger';
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

export class CreateScheduledNotificationInput {
  @ApiProperty()
  @IsString({ message: 'Title must be a string' })
  @MaxLength(30, { message: 'Title must be at most 30 characters long' })
  @IsNotEmpty({ message: 'Title is required' })
  title: string;

  @ApiProperty()
  @IsString({ message: 'Description must be a string' })
  @MaxLength(150, {
    message: 'Description must be at most 150 characters long',
  })
  @IsNotEmpty({ message: 'Description is required' })
  description: string;

  @ApiProperty()
  @IsString({ message: 'Redirect screen must be a string' })
  @IsOptional()
  redirectScreen?: string;

  @ApiProperty({ enum: UserNotificationType })
  @IsEnum(UserNotificationType, { message: 'Invalid notification type' })
  notificationType: UserNotificationType;

  @ApiProperty({ nullable: true })
  @IsMongoId({ message: 'User ID must be valid MongoDB ID' })
  @IsOptional()
  individualUserId?: string;

  @ApiProperty()
  @IsDateString()
  @IsDateNowOrInFuture({ message: 'Date must be now or in the future' })
  date: string;

  @ApiProperty({ enum: UserNotificationInterval })
  @IsEnum(UserNotificationInterval, {
    message: 'Invalid notification interval',
  })
  interval: UserNotificationInterval;

  @ApiProperty({ enum: UserGroup })
  @IsEnum(UserGroup, {
    message: 'Invalid user group',
  })
  targetGroup: UserGroup;
}
