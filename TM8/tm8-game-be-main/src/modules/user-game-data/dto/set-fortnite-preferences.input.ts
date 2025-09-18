import { ApiProperty } from '@nestjs/swagger';
import { IsIn, IsNotEmpty, IsNumber, Max, Min } from 'class-validator';

import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

const gameModeOptions: GamePreferenceValue[] = [
  GamePreferenceValue.BattleRoyaleBuild,
  GamePreferenceValue.BattleRoyaleNoBuild,
];

const rotateOptions: GamePreferenceValue[] = [
  GamePreferenceValue.CenterCircle,
  GamePreferenceValue.ChaseKill,
  GamePreferenceValue.ZoneWalk,
];

const teamSizeOptions: GamePreferenceValue[] = [
  GamePreferenceValue.Duo,
  GamePreferenceValue.Trio,
  GamePreferenceValue.Squad,
];

const playingLevelOptions: GamePreferenceValue[] = [
  GamePreferenceValue.FirstTime,
  GamePreferenceValue.Beginner,
  GamePreferenceValue.Intermediate,
  GamePreferenceValue.Advanced,
  GamePreferenceValue.Pro,
  GamePreferenceValue.Legend,
];

export class SetFortnitePreferencesInput {
  @ApiProperty()
  @IsIn(gameModeOptions, {
    each: true,
    message: `Please provide one of the values: ${gameModeOptions.join(', ')}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  gameModes: string[];

  @ApiProperty()
  @IsIn(rotateOptions, {
    each: true,
    message: `Please provide one of the values: ${rotateOptions.join(', ')}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  rotations: string[];

  @ApiProperty()
  @IsIn(playingLevelOptions, {
    message: `Please provide one of the values: ${playingLevelOptions.join(
      ', ',
    )}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  playingLevel: string;

  @ApiProperty()
  @IsIn(teamSizeOptions, {
    each: true,
    message: `Please provide one of the values: ${teamSizeOptions.join(', ')}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  teamSizes: string[];

  @ApiProperty()
  @IsNumber({}, { message: 'Please provide a number' })
  @Min(1)
  @Max(5)
  @IsNotEmpty({ message: 'Please provide a value' })
  agression: number;

  @ApiProperty()
  @IsNumber({}, { message: 'Please provide a number' })
  @Min(1)
  @Max(5)
  @IsNotEmpty({ message: 'Please provide a value' })
  teamWork: number;

  @ApiProperty()
  @IsNumber({}, { message: 'Please provide a number' })
  @Min(1)
  @Max(5)
  @IsNotEmpty({ message: 'Please provide a value' })
  gameplayStyle: number;

  /**
   * NOTE: Will be used later, not needed for now
   */
  /* @ApiProperty()
  @IsEnum(FortniteRank, {
    message: `Please provide one of the values: ${Object.values(FortniteRank)}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  rank: string; */
}
