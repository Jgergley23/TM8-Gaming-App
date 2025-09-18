import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

import { GamePreferenceResponse } from 'src/modules/user-game-data/response/game-preference.response';

export class MatchmakingResultUserResponse {
  @ApiProperty()
  id: string;

  @ApiProperty({ nullable: true })
  photoKey: string | null;

  @ApiProperty({ nullable: true })
  audioKey: string | null;

  @ApiProperty()
  username: string;

  @ApiProperty({ type: Date })
  dateOfBirth: Date;

  @ApiPropertyOptional()
  country?: string;

  @ApiProperty({ type: [GamePreferenceResponse] })
  preferences: GamePreferenceResponse[];
}
