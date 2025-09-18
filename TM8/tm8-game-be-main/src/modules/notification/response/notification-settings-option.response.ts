import { ApiProperty } from '@nestjs/swagger';

export class NotificationSettingsOptionResponse {
  @ApiProperty()
  keyValue: string;

  @ApiProperty()
  displayValue: string;
}
