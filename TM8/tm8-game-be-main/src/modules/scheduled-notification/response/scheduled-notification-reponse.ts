import { ApiProperty } from '@nestjs/swagger';

import { UserNotificationInterval } from 'src/common/constants';

import { IScheduledNotificationRecord } from '../interfaces/scheduled-notification.interface';
import { ScheduledNotificationDataResponse } from './scheduled-notification-data.response';

export class ScheduledNotificationResponse
  implements IScheduledNotificationRecord
{
  @ApiProperty()
  _id: string;

  @ApiProperty()
  date: Date;

  @ApiProperty()
  interval: UserNotificationInterval;

  @ApiProperty()
  openedBy: number;

  @ApiProperty()
  receivedBy: number;

  @ApiProperty()
  uniqueId: string;

  @ApiProperty()
  users: string[];

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;

  @ApiProperty({ type: ScheduledNotificationDataResponse })
  data: ScheduledNotificationDataResponse;
}
