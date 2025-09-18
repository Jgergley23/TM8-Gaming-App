import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsNotEmpty } from 'class-validator';

import { ReportReason } from 'src/common/constants';

export class ReportUserInput {
  reporterId: string;

  targetId: string;

  @ApiProperty()
  @IsEnum(ReportReason, {
    message: `Invalid report reason, please provide one of: ${Object.values(
      ReportReason,
    )}`,
  })
  @IsNotEmpty({ message: 'Report reason is required' })
  reportReason: ReportReason;
}
