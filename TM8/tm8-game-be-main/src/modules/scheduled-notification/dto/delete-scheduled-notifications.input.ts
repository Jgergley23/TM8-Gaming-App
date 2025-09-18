import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId } from 'class-validator';

export class DeleteScheduledNotificationsInput {
  @ApiProperty()
  @IsMongoId({ each: true, message: 'Please provide a valid user id' })
  notificationIds: string[];
}
