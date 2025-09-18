import { ApiProperty } from '@nestjs/swagger';

import { UserNotificationInterval } from 'src/common/constants';
import { INotificationInterval } from 'src/common/interfaces/notification-interval.interface';

export class NotificationIntervalResponse implements INotificationInterval {
  @ApiProperty({ enum: UserNotificationInterval })
  key: UserNotificationInterval;

  @ApiProperty()
  name: string;
}
