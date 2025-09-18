import { GamePreferenceQuestionType } from 'src/common/constants';
import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

import { IGamePreferenceForm } from '../interface/game-preference-form.interface';

export const fortnitePreferenceForm: IGamePreferenceForm[] = [
  {
    title: 'Game Mode',
    type: GamePreferenceQuestionType.MultiSelect,
    selectOptions: [
      {
        display: 'Battle Royale Build',
        attribute: GamePreferenceValue.BattleRoyaleBuild,
      },
      {
        display: 'Battle Royale No Build',
        attribute: GamePreferenceValue.BattleRoyaleNoBuild,
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
        maxValue: 'Agressive',
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
        display: 'Bronze I',
        attribute: FortniteRank.BronzeI,
      },
      {
        display: 'Bronze II',
        attribute: FortniteRank.BronzeII,
      },
      {
        display: 'Bronze III',
        attribute: FortniteRank.BronzeIII,
      },
      {
        display: 'Silver I',
        attribute: FortniteRank.SilverI,
      },
      {
        display: 'Silver II',
        attribute: FortniteRank.SilverII,
      },
      {
        display: 'Silver III',
        attribute: FortniteRank.SilverIII,
      },
      {
        display: 'Gold I',
        attribute: FortniteRank.GoldI,
      },
      {
        display: 'Gold II',
        attribute: FortniteRank.GoldII,
      },
      {
        display: 'Gold III',
        attribute: FortniteRank.GoldIII,
      },
      {
        display: 'Platinum I',
        attribute: FortniteRank.PlatinumI,
      },
      {
        display: 'Platinum II',
        attribute: FortniteRank.PlatinumII,
      },
      {
        display: 'Platinum III',
        attribute: FortniteRank.PlatinumIII,
      },
      {
        display: 'Diamond I',
        attribute: FortniteRank.DiamondI,
      },
      {
        display: 'Diamond II',
        attribute: FortniteRank.DiamondII,
      },
      {
        display: 'Diamond III',
        attribute: FortniteRank.DiamondIII,
      },
      {
        display: 'Elite',
        attribute: FortniteRank.Elite,
      },
      {
        display: 'Champion',
        attribute: FortniteRank.Champion,
      },
      {
        display: 'Unreal',
        attribute: FortniteRank.Unreal,
      },
    ],
  }, */
];
