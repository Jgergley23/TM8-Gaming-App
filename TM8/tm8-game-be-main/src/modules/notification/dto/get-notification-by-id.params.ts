import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId } from 'class-validator';

export class GetNotificationByIdParams {
  @ApiProperty({
    name: 'notificationId',
    description: 'Notification ID',
    type: String,
  })
  @IsMongoId({ message: 'Notification ID should be a valid Object ID' })
  notificationId: string;
}
