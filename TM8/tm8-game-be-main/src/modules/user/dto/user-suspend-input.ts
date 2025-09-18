import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsDate,
  IsMongoId,
  IsNotEmpty,
  IsString,
  MaxLength,
} from 'class-validator';

import { IsDateNowOrInFuture } from 'src/common/validation/is-date-now-or-in-future.validator';

export class UserSuspendInput {
  @ApiProperty()
  @IsMongoId({ each: true, message: 'Please provide a valid user id' })
  userIds: string[];

  @ApiProperty()
  @Type(() => Date)
  @IsDate({ message: 'Please provide a valid date' })
  @IsDateNowOrInFuture({ message: 'Date must be now or in the future' })
  until: Date;

  @ApiProperty()
  @IsString({ message: 'Please provide a note' })
  @IsNotEmpty({ message: 'Note cannot be empty' })
  @MaxLength(60, { message: 'Note can be maximum 60 characters long' })
  note: string;
}
