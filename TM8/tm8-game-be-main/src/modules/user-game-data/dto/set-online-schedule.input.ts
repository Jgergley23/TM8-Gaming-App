import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsDate } from 'class-validator';
import { utc } from 'moment';

export class SetOnlineScheduleInput {
  @ApiProperty()
  @Transform(({ value }) => utc(value).toDate())
  @IsDate({ message: 'Please provide a valid starting timestamp' })
  startingTimestamp: Date;

  @ApiProperty()
  @Transform(({ value }) => utc(value).toDate())
  @IsDate({ message: 'Please provide a valid ending timestamp' })
  endingTimestamp: Date;
}
