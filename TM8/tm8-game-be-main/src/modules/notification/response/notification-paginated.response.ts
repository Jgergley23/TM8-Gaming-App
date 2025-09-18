import { ApiProperty } from '@nestjs/swagger';

import { PaginationMetaResponse } from 'src/common/pagination/pagination-meta.response';

import { NotificationResponse } from './notification.response';

export class NotificationPaginatedResponse {
  @ApiProperty()
  items: NotificationResponse[];

  @ApiProperty()
  meta: PaginationMetaResponse;
}
