import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class UnreadNotificationsResponse {
  @ApiProperty()
  unread: boolean;

  @ApiPropertyOptional()
  count?: number;
}
