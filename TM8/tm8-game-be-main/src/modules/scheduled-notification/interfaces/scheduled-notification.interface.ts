import { UserNotificationInterval } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { IScheduledNotificationDataRecord } from './scheduled-notification-data.interface';

export interface IScheduledNotification {
  date: Date;
  interval: UserNotificationInterval;
  users: string[] | User[];
  data: IScheduledNotificationDataRecord;
  receivedBy: number;
  openedBy: number;
  uniqueId: string;
}

export interface IScheduledNotificationRecord extends IScheduledNotification {
  _id: string;
  createdAt?: Date;
  updatedAt?: Date;
}
