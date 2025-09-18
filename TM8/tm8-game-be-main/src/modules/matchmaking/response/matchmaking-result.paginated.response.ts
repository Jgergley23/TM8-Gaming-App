import { ApiProperty } from '@nestjs/swagger';

import { PaginationMetaResponse } from 'src/common/pagination/pagination-meta.response';

import { MatchmakingResultUserResponse } from './matchmaking-result-user.response';

export class MatchmakingResultPaginatedResponse {
  @ApiProperty()
  items: MatchmakingResultUserResponse[];

  @ApiProperty()
  meta: PaginationMetaResponse;
}
