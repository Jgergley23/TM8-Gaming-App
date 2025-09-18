import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsIn,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  Max,
  Min,
} from 'class-validator';

import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

const typeOptions: GamePreferenceValue[] = [
  GamePreferenceValue.FiringRange,
  GamePreferenceValue.Mixtape,
  GamePreferenceValue.BattleRoyale,
  GamePreferenceValue.FiringSquad,
];

const classificationsOptions: GamePreferenceValue[] = [
  GamePreferenceValue.Assault,
  GamePreferenceValue.Skirmisher,
  GamePreferenceValue.Recon,
  GamePreferenceValue.Controller,
  GamePreferenceValue.Support,
];

const mixtapeTypeOptions: GamePreferenceValue[] = [
  GamePreferenceValue.Control,
  GamePreferenceValue.TeamDeathmatch,
  GamePreferenceValue.GunGame,
];

const teamSizeOptions: GamePreferenceValue[] = [
  GamePreferenceValue.Duo,
  GamePreferenceValue.Trio,
];

const playingLevelOptions: GamePreferenceValue[] = [
  GamePreferenceValue.FirstTime,
  GamePreferenceValue.Beginner,
  GamePreferenceValue.Intermediate,
  GamePreferenceValue.Advanced,
  GamePreferenceValue.Pro,
  GamePreferenceValue.Legend,
];

const rotateOptions: GamePreferenceValue[] = [
  GamePreferenceValue.CenterCircle,
  GamePreferenceValue.ChaseKill,
  GamePreferenceValue.ZoneWalk,
];

export class SetApexLegendsPreferencesInput {
  @ApiProperty()
  @IsIn(typeOptions, {
    each: true,
    message: `Please provide one of the values: ${typeOptions.join(', ')}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  types: string[];

  @ApiProperty()
  @IsIn(classificationsOptions, {
    each: true,
    message: `Please provide at least one of the values: ${classificationsOptions.join(
      ', ',
    )}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  classifications: string[];

  @ApiProperty()
  @IsIn(playingLevelOptions, {
    message: `Please provide one of the values: ${playingLevelOptions.join(
      ', ',
    )}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  playingLevel: string;

  @ApiPropertyOptional()
  @IsIn(mixtapeTypeOptions, {
    each: true,
    message: `Please provide one of the values: ${mixtapeTypeOptions.join(
      ', ',
    )}`,
  })
  @IsOptional()
  mixtapeTypes?: string[];

  @ApiProperty()
  @IsIn(rotateOptions, {
    each: true,
    message: `Please provide one of the values: ${rotateOptions.join(', ')}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  rotations: string[];

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
  @IsEnum(ApexLegendsRank, {
    message: `Please provide one of the values: ${Object.values(
      ApexLegendsRank,
    )}`,
  })
  @IsNotEmpty({ message: 'Please provide a value' })
  rank: string; */
}
