import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

import { UserNotificationSettingsResponse } from './user-notification-settings.response';

export class GetMeUserResponse {
  @ApiProperty()
  id: string;

  @ApiProperty()
  username: string;

  @ApiPropertyOptional()
  photoKey?: string;

  @ApiPropertyOptional()
  audioKey?: string;

  @ApiProperty()
  games: string[];

  @ApiProperty()
  friends: number;

  @ApiProperty()
  email: string;

  @ApiPropertyOptional()
  description?: string;

  @ApiPropertyOptional()
  gender?: string;

  @ApiPropertyOptional()
  regions?: string[];

  @ApiPropertyOptional()
  dateOfBirth?: Date;

  @ApiPropertyOptional()
  country?: string;

  @ApiPropertyOptional()
  language?: string;

  @ApiPropertyOptional()
  epicGamesUsername?: string;

  @ApiProperty({ type: UserNotificationSettingsResponse })
  notificationSettings: UserNotificationSettingsResponse;
}
