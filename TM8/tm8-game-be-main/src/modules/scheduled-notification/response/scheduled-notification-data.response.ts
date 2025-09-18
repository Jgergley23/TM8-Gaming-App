import { ApiProperty } from '@nestjs/swagger';

import { UserGroup, UserNotificationType } from 'src/common/constants';

import { IScheduledNotificationDataRecord } from '../interfaces/scheduled-notification-data.interface';

export class ScheduledNotificationDataResponse
  implements IScheduledNotificationDataRecord
{
  @ApiProperty()
  title: string;

  @ApiProperty()
  description: string;

  @ApiProperty()
  targetGroup: UserGroup;

  @ApiProperty()
  notificationType: UserNotificationType;
}
