import { GamePreferenceQuestionType } from 'src/common/constants';
import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

import { IGamePreferenceForm } from '../interface/game-preference-form.interface';

export const apexLegendsPreferenceForm: IGamePreferenceForm[] = [
  {
    title: 'Type',
    type: GamePreferenceQuestionType.MultiSelect,
    selectOptions: [
      {
        display: 'Firing Range',
        attribute: GamePreferenceValue.FiringRange,
      },
      {
        display: 'Battle Royale',
        attribute: GamePreferenceValue.BattleRoyale,
      },
      {
        display: 'Firing Squad',
        attribute: GamePreferenceValue.FiringSquad,
      },
      {
        display: 'Mixtape',
        attribute: GamePreferenceValue.Mixtape,
        cascade: {
          title: 'Mixtape Type',
          type: GamePreferenceQuestionType.MultiSelect,
          selectOptions: [
            {
              display: 'Control',
              attribute: GamePreferenceValue.Control,
            },
            {
              display: 'Team Deathmatch',
              attribute: GamePreferenceValue.TeamDeathmatch,
            },
            {
              display: 'Gun Game',
              attribute: GamePreferenceValue.GunGame,
            },
          ],
        },
      },
    ],
  },
  {
    title: 'Classifications',
    type: GamePreferenceQuestionType.MultiSelect,
    selectOptions: [
      {
        display: 'Assault',
        attribute: GamePreferenceValue.Assault,
      },
      {
        display: 'Skirmisher',
        attribute: GamePreferenceValue.Skirmisher,
      },
      {
        display: 'Recon',
        attribute: GamePreferenceValue.Recon,
      },
      {
        display: 'Controller',
        attribute: GamePreferenceValue.Controller,
      },
      {
        display: 'Support',
        attribute: GamePreferenceValue.Support,
      },
    ],
  },

  {
    title: 'Team Size',
    type: GamePreferenceQuestionType.MultiSelect,
    selectOptions: [
      {
        display: 'Duo',
        attribute: GamePreferenceValue.Duo,
      },
      {
        display: 'Trio',
        attribute: GamePreferenceValue.Trio,
      },
    ],
  },
  {
    title: 'Playing Level',
    type: GamePreferenceQuestionType.Select,
    selectOptions: [
      {
        display: 'First Time',
        attribute: GamePreferenceValue.FirstTime,
      },
      {
        display: 'Beginner',
        attribute: GamePreferenceValue.Beginner,
      },
      {
        display: 'Intermediate',
        attribute: GamePreferenceValue.Intermediate,
      },
      {
        display: 'Advanced',
        attribute: GamePreferenceValue.Advanced,
      },
      {
        display: 'Pro',
        attribute: GamePreferenceValue.Pro,
      },
      {
        display: 'Legend',
        attribute: GamePreferenceValue.Legend,
      },
    ],
  },
  {
    title: 'Rotate',
    type: GamePreferenceQuestionType.MultiSelect,
    selectOptions: [
      {
        display: 'Center Circle',
        attribute: GamePreferenceValue.CenterCircle,
      },
      {
        display: 'Chase Kill',
        attribute: GamePreferenceValue.ChaseKill,
      },
      {
        display: 'Zone Walk',
        attribute: GamePreferenceValue.ZoneWalk,
      },
    ],
  },
  {
    title: 'Play Style',
    type: GamePreferenceQuestionType.Slider,
    sliderOptions: [
      {
        minValue: 'Passive',
        maxValue: 'Aggressive',
        attribute: GamePreferenceValue.Aggressive,
      },
      {
        minValue: 'Lone Wolf',
        maxValue: 'Team Player',
        attribute: GamePreferenceValue.TeamPlayer,
      },
      {
        minValue: 'Loot',
        maxValue: 'Find People',
        attribute: GamePreferenceValue.FindPeople,
      },
    ],
  },
  /**
   * NOTE: Will be used later, not needed for now
   */
  /* {
    title: 'Rank',
    type: GamePreferenceQuestionType.Dropdown,
    dropdownOptions: [
      {
        display: 'Rookie IV',
        attribute: ApexLegendsRank.RookieIV,
      },
      {
        display: 'Rookie III',
        attribute: ApexLegendsRank.RookieIII,
      },
      {
        display: 'Rookie II',
        attribute: ApexLegendsRank.RookieII,
      },
      {
        display: 'Rookie I',
        attribute: ApexLegendsRank.RookieI,
      },
      {
        display: 'Bronze IV',
        attribute: ApexLegendsRank.BronzeIV,
      },
      {
        display: 'Bronze III',
        attribute: ApexLegendsRank.BronzeIII,
      },
      {
        display: 'Bronze II',
        attribute: ApexLegendsRank.BronzeII,
      },
      {
        display: 'Bronze I',
        attribute: ApexLegendsRank.BronzeI,
      },
      {
        display: 'Silver IV',
        attribute: ApexLegendsRank.SilverIV,
      },
      {
        display: 'Silver III',
        attribute: ApexLegendsRank.SilverIII,
      },
      {
        display: 'Silver II',
        attribute: ApexLegendsRank.SilverII,
      },
      {
        display: 'Silver I',
        attribute: ApexLegendsRank.SilverI,
      },
      {
        display: 'Gold IV',
        attribute: ApexLegendsRank.GoldIV,
      },
      {
        display: 'Gold III',
        attribute: ApexLegendsRank.GoldIII,
      },
      {
        display: 'Gold II',
        attribute: ApexLegendsRank.GoldII,
      },
      {
        display: 'Gold I',
        attribute: ApexLegendsRank.GoldI,
      },
      {
        display: 'Platinum IV',
        attribute: ApexLegendsRank.PlatinumIV,
      },
      {
        display: 'Platinum III',
        attribute: ApexLegendsRank.PlatinumIII,
      },
      {
        display: 'Platinum II',
        attribute: ApexLegendsRank.PlatinumII,
      },
      {
        display: 'Platinum I',
        attribute: ApexLegendsRank.PlatinumI,
      },
      {
        display: 'Diamond IV',
        attribute: ApexLegendsRank.DiamondIV,
      },
      {
        display: 'Diamond III',
        attribute: ApexLegendsRank.DiamondIII,
      },
      {
        display: 'Diamond II',
        attribute: ApexLegendsRank.DiamondII,
      },
      {
        display: 'Diamond I',
        attribute: ApexLegendsRank.DiamondI,
      },
      {
        display: 'Master',
        attribute: ApexLegendsRank.Master,
      },
      {
        display: 'Apex Predator',
        attribute: ApexLegendsRank.ApexPredator,
      },
    ],
  }, */
];
