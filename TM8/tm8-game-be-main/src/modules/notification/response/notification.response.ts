import { ApiProperty } from '@nestjs/swagger';

import { UserNotificationType } from 'src/common/constants';

import {
  INotificationDataRecord,
  INotificationRecord,
} from '../interfaces/notification.interface';

export class NotificationDataResponse
  implements Partial<INotificationDataRecord>
{
  @ApiProperty()
  title: string;

  @ApiProperty()
  description: string;

  @ApiProperty()
  redirectScreen: string;

  @ApiProperty()
  isRead: boolean;

  @ApiProperty()
  notificationType: UserNotificationType;
}

export class NotificationResponse implements Partial<INotificationRecord> {
  @ApiProperty()
  _id: string;

  @ApiProperty()
  user: string;

  @ApiProperty()
  since: Date;

  @ApiProperty()
  until: Date;

  @ApiProperty({ type: NotificationDataResponse })
  data: NotificationDataResponse;

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;
}
