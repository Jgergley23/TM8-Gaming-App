import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId } from 'class-validator';

export class GetNotificationByIdParams {
  @ApiProperty({
    name: 'notificationId',
    description: 'Scheduled Notification ID',
    type: String,
  })
  @IsMongoId({
    message: 'Scheduled notification ID should be a valid Object ID',
  })
  notificationId: string;
}
