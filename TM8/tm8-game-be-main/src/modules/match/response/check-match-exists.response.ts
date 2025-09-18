import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CheckMatchExistsResponse {
  @ApiProperty()
  matchExists: boolean;

  @ApiPropertyOptional()
  matchId?: string;
}
