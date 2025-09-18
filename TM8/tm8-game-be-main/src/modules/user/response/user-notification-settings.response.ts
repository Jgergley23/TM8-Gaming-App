import { ApiProperty } from '@nestjs/swagger';

export class UserNotificationSettingsResponse {
  @ApiProperty()
  enabled: boolean;

  @ApiProperty()
  match: boolean;

  @ApiProperty()
  message: boolean;

  @ApiProperty()
  friendAdded: boolean;

  @ApiProperty()
  news: boolean;

  @ApiProperty()
  reminders: boolean;
}
