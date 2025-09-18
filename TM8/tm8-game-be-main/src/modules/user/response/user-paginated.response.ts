import { ApiProperty } from '@nestjs/swagger';

import { PaginationMetaResponse } from 'src/common/pagination/pagination-meta.response';

import { UserResponse } from './user.response';

export class UserPaginatedResponse {
  @ApiProperty()
  items: UserResponse[];

  @ApiProperty()
  meta: PaginationMetaResponse;
}
