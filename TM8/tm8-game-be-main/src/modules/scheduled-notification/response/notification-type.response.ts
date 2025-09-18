import { ApiProperty } from '@nestjs/swagger';

import { UserNotificationType } from 'src/common/constants';
import { INotificationType } from 'src/common/interfaces/notification-type.interface';

export class NotificationTypeResponse implements INotificationType {
  @ApiProperty({ enum: UserNotificationType })
  key: UserNotificationType;

  @ApiProperty()
  name: string;
}
