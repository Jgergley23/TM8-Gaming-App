import { ApiProperty } from '@nestjs/swagger';

import { ReportReason } from 'src/common/constants';

export class UserReportResponse {
  @ApiProperty()
  reporter: string;

  @ApiProperty({ enum: ReportReason })
  reportReason: ReportReason;

  @ApiProperty()
  createdAt: Date;
}
