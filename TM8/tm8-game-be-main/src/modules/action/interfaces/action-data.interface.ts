import { ReportReason } from 'src/common/constants/report-reason.enum';
import { User } from 'src/modules/user/schemas/user.schema';

export interface IActionData {
  reportReason?: ReportReason;
  user: string | User;
}

export interface IActionDataRecord extends IActionData {
  createdAt?: Date;
  updatedAt?: Date;
}
