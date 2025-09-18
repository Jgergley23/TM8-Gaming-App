import { ApiProperty } from '@nestjs/swagger';

import { ReportReason } from 'src/common/constants';
import { IUserReportType } from 'src/common/interfaces/user-report-type.interface';

export class UserReportTypeResponse implements IUserReportType {
  @ApiProperty({ enum: ReportReason })
  key: ReportReason;

  @ApiProperty()
  name: string;
}
