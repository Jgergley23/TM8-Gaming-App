import { ApiProperty } from '@nestjs/swagger';

export class StatisticsOnboardingCompletionResponse {
  @ApiProperty()
  onboardingPct: number;
  @ApiProperty()
  currentWeek: number;
}
