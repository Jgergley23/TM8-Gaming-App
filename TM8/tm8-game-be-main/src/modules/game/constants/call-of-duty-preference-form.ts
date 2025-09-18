import { GamePreferenceQuestionType } from 'src/common/constants';
import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

import { IGamePreferenceForm } from '../interface/game-preference-form.interface';

export const callOfDutyPreferenceForm: IGamePreferenceForm[] = [
  {
    title: 'Game Mode',
    type: GamePreferenceQuestionType.MultiSelect,
    selectOptions: [
      {
        display: 'Battle Royale',
        attribute: GamePreferenceValue.BattleRoyale,
      },
      {
        display: 'Resurgence',
        attribute: GamePreferenceValue.Resurgence,
      },
      {
        display: 'Plunder',
        attribute: GamePreferenceValue.Plunder,
      },
      {
        display: 'Gun Game',
        attribute: GamePreferenceValue.GunGame,
      },
      {
        display: 'Quick Games',
        attribute: GamePreferenceValue.QuickGames,
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
      {
        display: 'Squad',
        attribute: GamePreferenceValue.Squad,
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
  /**
   * NOTE: Will be used later, not needed for now
   */
  /* {
    title: 'Rank',
    type: GamePreferenceQuestionType.Dropdown,
    dropdownOptions: [
      {
        display: 'Bronze I',
        attribute: CallOfDutyRank.BronzeI,
      },
      {
        display: 'Bronze II',
        attribute: CallOfDutyRank.BronzeII,
      },
      {
        display: 'Bronze III',
        attribute: CallOfDutyRank.BronzeIII,
      },
      {
        display: 'Silver I',
        attribute: CallOfDutyRank.SilverI,
      },
      {
        display: 'Silver II',
        attribute: CallOfDutyRank.SilverII,
      },
      {
        display: 'Silver III',
        attribute: CallOfDutyRank.SilverIII,
      },
      {
        display: 'Gold I',
        attribute: CallOfDutyRank.GoldI,
      },
      {
        display: 'Gold II',
        attribute: CallOfDutyRank.GoldII,
      },
      {
        display: 'Gold III',
        attribute: CallOfDutyRank.GoldIII,
      },
      {
        display: 'Platinum I',
        attribute: CallOfDutyRank.PlatinumI,
      },
      {
        display: 'Platinum II',
        attribute: CallOfDutyRank.PlatinumII,
      },
      {
        display: 'Platinum III',
        attribute: CallOfDutyRank.PlatinumIII,
      },
      {
        display: 'Diamond I',
        attribute: CallOfDutyRank.DiamondI,
      },
      {
        display: 'Diamond II',
        attribute: CallOfDutyRank.DiamondII,
      },
      {
        display: 'Diamond III',
        attribute: CallOfDutyRank.DiamondIII,
      },
      {
        display: 'Crimson I',
        attribute: CallOfDutyRank.CrimsonI,
      },
      {
        display: 'Crimson II',
        attribute: CallOfDutyRank.CrimsonII,
      },
      {
        display: 'Crimson III',
        attribute: CallOfDutyRank.CrimsonIII,
      },
      {
        display: 'Iridescent',
        attribute: CallOfDutyRank.Iridescent,
      },
      {
        display: 'Top 250',
        attribute: CallOfDutyRank.Top250,
      },
    ],
  }, */
];
