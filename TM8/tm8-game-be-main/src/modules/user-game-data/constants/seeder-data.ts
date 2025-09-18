import { GamePreferenceKey, Playtime } from 'src/common/constants';
import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

import { UserGamePreference } from '../schemas/user-game-preference.schema';

export const rocketLeaguePreferences: UserGamePreference[] = [
  {
    key: GamePreferenceKey.GameMode,
    title: 'Game Mode',
    values: [
      {
        key: GamePreferenceValue.Casual,
        selectedValue: 'Casual',
      },
    ],
  },
  {
    key: GamePreferenceKey.TeamSize,
    title: 'Team Size',
    values: [
      {
        key: GamePreferenceValue.Duo,
        selectedValue: 'Duo',
      },
      {
        key: GamePreferenceValue.Trio,
        selectedValue: 'Trio',
      },
    ],
  },
  {
    key: GamePreferenceKey.PlayingLevel,
    title: 'Playing Level',
    values: [
      {
        key: GamePreferenceValue.Beginner,
        selectedValue: 'Beginner',
      },
    ],
  },
  {
    key: GamePreferenceKey.PlayStyle,
    title: 'Play Style',
    values: [
      {
        key: GamePreferenceValue.DemoHeavy,
        selectedValue: 'Demo-Heavy',
      },
    ],
  },
  {
    key: GamePreferenceKey.Gameplay,
    title: 'Gameplay',
    values: [
      {
        key: GamePreferenceValue.OffensiveScorer,
        selectedValue: 'Offensive Scorer',
      },
      {
        key: GamePreferenceValue.DefensiveScorer,
        selectedValue: 'Defensive Scorer',
      },
    ],
  },
  {
    key: GamePreferenceKey.Playtime,
    title: 'Playtime',
    values: [
      {
        key: Playtime.TwoHours,
        selectedValue: '2 Hours',
      },
    ],
  },
];

export const apexLegendsPreferences: UserGamePreference[] = [
  {
    key: GamePreferenceKey.Type,
    title: 'Type',
    values: [
      {
        key: GamePreferenceValue.FiringRange,
        selectedValue: 'Firing Range',
      },
      {
        key: GamePreferenceValue.BattleRoyale,
        selectedValue: 'Battle Royale',
      },
      {
        key: GamePreferenceValue.Mixtape,
        selectedValue: 'Mixtape',
      },
    ],
  },
  {
    key: GamePreferenceKey.MixtapeType,
    title: 'Mixtape Type',
    values: [
      {
        key: GamePreferenceValue.TeamDeathmatch,
        selectedValue: 'Team Deathmatch',
      },
    ],
  },
  {
    key: GamePreferenceKey.Classifications,
    title: 'Classifications',
    values: [
      {
        key: GamePreferenceValue.Assault,
        selectedValue: 'Assault',
      },
      {
        key: GamePreferenceValue.Recon,
        selectedValue: 'Recon',
      },
    ],
  },
  {
    key: GamePreferenceKey.TeamSize,
    title: 'Team Size',
    values: [
      {
        key: GamePreferenceValue.Duo,
        selectedValue: 'Duo',
      },
      {
        key: GamePreferenceValue.Trio,
        selectedValue: 'Trio',
      },
    ],
  },
  {
    key: GamePreferenceKey.Rotate,
    title: 'Rotate',
    values: [
      {
        key: GamePreferenceValue.ChaseKill,
        selectedValue: 'Chase Kill',
      },
      {
        key: GamePreferenceValue.ZoneWalk,
        selectedValue: 'Zone Walk',
      },
    ],
  },
  {
    key: GamePreferenceKey.PlayingLevel,
    title: 'Playing level',
    values: [
      {
        key: GamePreferenceValue.Intermediate,
        selectedValue: 'Intermediate',
      },
    ],
  },
  {
    key: GamePreferenceKey.PlayStyle,
    title: 'Play Syle',
    values: [
      {
        key: GamePreferenceValue.Aggressive,
        numericValue: 1,
        numericDisplay: 'Aggressive',
      },
      {
        key: GamePreferenceValue.TeamPlayer,
        numericValue: 4,
        numericDisplay: 'Team player',
      },
      {
        key: GamePreferenceValue.FindPeople,
        numericValue: 3,
        numericDisplay: 'Find people',
      },
    ],
  },
  {
    key: GamePreferenceKey.Playtime,
    title: 'Playtime',
    values: [
      {
        key: Playtime.TwoHours,
        selectedValue: '2 Hours',
      },
    ],
  },
];

export const callOfDutyPreferences: UserGamePreference[] = [
  {
    key: GamePreferenceKey.GameMode,
    title: 'Game Mode',
    values: [
      {
        key: GamePreferenceValue.BattleRoyale,
        selectedValue: 'Battle Royale',
      },
      {
        key: GamePreferenceValue.Resurgence,
        selectedValue: 'Resurgence',
      },
    ],
  },
  {
    key: GamePreferenceKey.Rotate,
    title: 'Rotate',
    values: [
      {
        key: GamePreferenceValue.ChaseKill,
        selectedValue: 'Chase Kill',
      },
      {
        key: GamePreferenceValue.CenterCircle,
        selectedValue: 'Center Circle',
      },
    ],
  },
  {
    key: GamePreferenceKey.TeamSize,
    title: 'Team size',
    values: [
      {
        key: GamePreferenceValue.Duo,
        selectedValue: 'Duo',
      },
      {
        key: GamePreferenceValue.Trio,
        selectedValue: 'Trio',
      },
      {
        key: GamePreferenceValue.Squad,
        selectedValue: 'Squad',
      },
    ],
  },
  {
    key: GamePreferenceKey.PlayingLevel,
    title: 'Playing level',
    values: [
      {
        key: GamePreferenceValue.Intermediate,
        selectedValue: 'Intermediate',
      },
    ],
  },
  {
    key: GamePreferenceKey.PlayStyle,
    title: 'Play Syle',
    values: [
      {
        key: GamePreferenceValue.Aggressive,
        numericValue: 1,
        numericDisplay: 'Aggressive',
      },
      {
        key: GamePreferenceValue.TeamPlayer,
        numericValue: 4,
        numericDisplay: 'Team player',
      },
      {
        key: GamePreferenceValue.FindPeople,
        numericValue: 3,
        numericDisplay: 'Find people',
      },
    ],
  },
  {
    key: GamePreferenceKey.Playtime,
    title: 'Playtime',
    values: [
      {
        key: Playtime.TwoHours,
        selectedValue: '2 Hours',
      },
    ],
  },
];

export const fortnitePreferences: UserGamePreference[] = [
  {
    key: GamePreferenceKey.GameMode,
    title: 'Game Mode',
    values: [
      {
        key: GamePreferenceValue.BattleRoyaleBuild,
        selectedValue: 'Battle Royale Build',
      },
      {
        key: GamePreferenceValue.BattleRoyaleNoBuild,
        selectedValue: 'Battle Royale No Build',
      },
    ],
  },
  {
    key: GamePreferenceKey.TeamSize,
    title: 'Team Size',
    values: [
      {
        key: GamePreferenceValue.Duo,
        selectedValue: 'Duo',
      },
      {
        key: GamePreferenceValue.Trio,
        selectedValue: 'Trio',
      },
    ],
  },
  {
    key: GamePreferenceKey.PlayingLevel,
    title: 'Playing Level',
    values: [
      {
        key: GamePreferenceValue.Intermediate,
        selectedValue: 'Intermediate',
      },
    ],
  },
  {
    key: GamePreferenceKey.Rotate,
    title: 'Rotate',
    values: [
      {
        key: GamePreferenceValue.CenterCircle,
        selectedValue: 'Center Circle',
      },
      {
        key: GamePreferenceValue.ZoneWalk,
        selectedValue: 'Zone Walk',
      },
    ],
  },
  {
    key: GamePreferenceKey.PlayStyle,
    title: 'Play Style',
    values: [
      {
        key: GamePreferenceValue.Aggressive,
        numericValue: 4,
        numericDisplay: 'Aggressive',
      },
      {
        key: GamePreferenceValue.TeamPlayer,
        numericValue: 2,
        numericDisplay: 'Team Player',
      },
      {
        key: GamePreferenceValue.FindPeople,
        numericValue: 3,
        numericDisplay: 'Find People',
      },
    ],
  },
  {
    key: GamePreferenceKey.Playtime,
    title: 'Playtime',
    values: [
      {
        key: Playtime.TwoHours,
        selectedValue: '2 Hours',
      },
    ],
  },
];
