import { ApiProperty } from '@nestjs/swagger';
import { IsIn, IsNotEmpty } from 'class-validator';

import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

const gameModeOptions: GamePreferenceValue[] = [
  GamePreferenceValue.Casual,
  GamePreferenceValue.Tournaments,
];

const teamSizeOptions: GamePreferenceValue[] = [
  GamePreferenceValue.Duo,
  GamePreferenceValue.Trio,
];

const gameplayOptions: GamePreferenceValue[] = [
  GamePreferenceValue.OffensiveScorer,
  GamePreferenceValue.OffensivePasser,
  GamePreferenceValue.DefensivePasser,
  GamePreferenceValue.DefensiveScorer,
  GamePreferenceValue.MidDefender,
  GamePreferenceValue.MidScorer,
];

const playingLevelOptions: GamePreferenceValue[] = [
  GamePreferenceValue.FirstTime,
  GamePreferenceValue.Beginner,
  GamePreferenceValue.Intermediate,
  GamePreferenceValue.Advanced,
  GamePreferenceValue.Pro,
  GamePreferenceValue.Legend,
];

const playstyleOptions: GamePreferenceValue[] = [
  GamePreferenceValue.DemoHeavy,
  GamePreferenceValue.Aggressive,
  GamePreferenceValue.OneVOne,
  GamePreferenceValue.Passer,
  GamePreferenceValue.Anchor,
];

export class SetRocketLeaguePreferencesInput {
  @ApiProperty()
  @IsIn(gameModeOptions, {
    each: true,
    message: `Please provide one of the values: ${gameModeOptions.join(', ')}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  gameModes: string[];

  @ApiProperty()
  @IsIn(playingLevelOptions, {
    message: `Please provide one of the values: ${playingLevelOptions.join(
      ', ',
    )}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  playingLevel: string;

  @ApiProperty()
  @IsIn(playstyleOptions, {
    message: `Please provide one of the values: ${playstyleOptions.join(', ')}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  playStyle: string;

  @ApiProperty()
  @IsIn(teamSizeOptions, {
    each: true,
    message: `Please provide one of the values: ${teamSizeOptions.join(', ')}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  teamSizes: string[];

  @ApiProperty()
  @IsIn(gameplayOptions, {
    each: true,
    message: `Please provide one of the values: ${gameplayOptions.join(', ')}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  gameplays: string[];

  /**
   * NOTE: Will be used later, not needed for now
   */
  /* @ApiProperty()
  @IsEnum(RocketLeagueRank, {
    message: `Please provide one of the values: ${Object.values(
      RocketLeagueRank,
    )}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  rank: string; */
}
