import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsEnum,
  IsMongoId,
  IsNotEmpty,
  IsString,
  MaxLength,
} from 'class-validator';

import { WarningReason } from 'src/common/constants';

export class UserWarningInput {
  @ApiProperty()
  @IsMongoId({ each: true, message: 'Please provide a valid user id' })
  userIds: string[];

  @ApiProperty()
  @IsString({ message: 'Please provide a note' })
  @IsNotEmpty({ message: 'Note cannot be empty' })
  @MaxLength(60, { message: 'Note can be maximum 60 characters long' })
  note: string;

  @ApiProperty({ enum: WarningReason })
  @Type(() => String)
  @IsEnum(WarningReason, { message: 'Please provide a valid warning reason' })
  warning: WarningReason;
}
