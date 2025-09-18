import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsDateString, IsEnum } from 'class-validator';

import { ChartGroup } from 'src/common/constants';

export class GetNewUsersRegisteredParams {
  @ApiProperty({
    description: 'Group parameter',
    type: String,
    enum: ChartGroup,
  })
  @Type(() => String)
  @IsEnum(ChartGroup, { message: 'Input must be one of group parameters' })
  groupBy: ChartGroup;

  @ApiProperty({
    description: 'Start date',
    type: String,
  })
  @IsDateString()
  startDate: string;

  @ApiProperty({
    description: 'End date',
    type: String,
  })
  @IsDateString()
  endDate: string;
}
