import { ApiProperty } from '@nestjs/swagger';

import { PaginationMetaResponse } from 'src/common/pagination/pagination-meta.response';

import { ScheduledNotificationResponse } from './scheduled-notification-reponse';

export class ScheduledNotificationPaginatedResponse {
  @ApiProperty()
  items: ScheduledNotificationResponse[];

  @ApiProperty()
  meta: PaginationMetaResponse;
}
