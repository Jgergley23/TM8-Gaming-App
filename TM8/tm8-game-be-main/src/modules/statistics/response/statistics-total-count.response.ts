import { ApiProperty } from '@nestjs/swagger';

export class StatisticsTotalCountResponse {
  @ApiProperty()
  total: number;
  @ApiProperty()
  currentWeek: number;
}
