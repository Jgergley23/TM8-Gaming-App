import { GamePreferenceQuestionType } from 'src/common/constants';
import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

import { IGamePreferenceForm } from '../interface/game-preference-form.interface';

export const rocketLeaguePreferenceForm: IGamePreferenceForm[] = [
  {
    title: 'Game Mode',
    type: GamePreferenceQuestionType.MultiSelect,
    selectOptions: [
      {
        display: 'Casual',
        attribute: GamePreferenceValue.Casual,
      },
      {
        display: 'Tournaments',
        attribute: GamePreferenceValue.Tournaments,
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
    title: 'Play Style',
    type: GamePreferenceQuestionType.Select,
    selectOptions: [
      {
        display: 'Demo-Heavy',
        attribute: GamePreferenceValue.DemoHeavy,
      },
      {
        display: 'Aggressive',
        attribute: GamePreferenceValue.Aggressive,
      },
      {
        display: '1v1',
        attribute: GamePreferenceValue.OneVOne,
      },
      {
        display: 'Passer',
        attribute: GamePreferenceValue.Passer,
      },
      {
        display: 'Anchor',
        attribute: GamePreferenceValue.Anchor,
      },
    ],
  },
  {
    title: 'Gameplay',
    type: GamePreferenceQuestionType.MultiSelect,
    selectOptions: [
      {
        display: 'Offensive Scorer',
        attribute: GamePreferenceValue.OffensiveScorer,
      },
      {
        display: 'Offensive Passer',
        attribute: GamePreferenceValue.OffensivePasser,
      },
      {
        display: 'Mid Scorer',
        attribute: GamePreferenceValue.MidScorer,
      },
      {
        display: 'Mid Defender',
        attribute: GamePreferenceValue.MidDefender,
      },
      {
        display: 'Defensive Scorer',
        attribute: GamePreferenceValue.DefensiveScorer,
      },
      {
        display: 'Defensive Passer',
        attribute: GamePreferenceValue.DefensivePasser,
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
        attribute: RocketLeagueRank.BronzeI,
      },
      {
        display: 'Bronze II',
        attribute: RocketLeagueRank.BronzeII,
      },
      {
        display: 'Bronze III',
        attribute: RocketLeagueRank.BronzeIII,
      },
      {
        display: 'Silver I',
        attribute: RocketLeagueRank.SilverI,
      },
      {
        display: 'Silver II',
        attribute: RocketLeagueRank.SilverII,
      },
      {
        display: 'Silver III',
        attribute: RocketLeagueRank.SilverIII,
      },
      {
        display: 'Gold I',
        attribute: RocketLeagueRank.GoldI,
      },
      {
        display: 'Gold II',
        attribute: RocketLeagueRank.GoldII,
      },
      {
        display: 'Gold III',
        attribute: RocketLeagueRank.GoldIII,
      },
      {
        display: 'Platinum I',
        attribute: RocketLeagueRank.PlatinumI,
      },
      {
        display: 'Platinum II',
        attribute: RocketLeagueRank.PlatinumII,
      },
      {
        display: 'Platinum III',
        attribute: RocketLeagueRank.PlatinumIII,
      },
      {
        display: 'Diamond I',
        attribute: RocketLeagueRank.DiamondI,
      },
      {
        display: 'Diamond II',
        attribute: RocketLeagueRank.DiamondII,
      },
      {
        display: 'Diamond III',
        attribute: RocketLeagueRank.DiamondIII,
      },
      {
        display: 'Champion I',
        attribute: RocketLeagueRank.ChampionI,
      },
      {
        display: 'Champion II',
        attribute: RocketLeagueRank.ChampionII,
      },
      {
        display: 'Champion III',
        attribute: RocketLeagueRank.ChampionIII,
      },
      {
        display: 'Grand Champion I',
        attribute: RocketLeagueRank.GrandChampionI,
      },
      {
        display: 'Grand Champion II',
        attribute: RocketLeagueRank.GrandChampionII,
      },
      {
        display: 'Grand Champion III',
        attribute: RocketLeagueRank.GrandChampionIII,
      },
      {
        display: 'Supersonic Legend',
        attribute: RocketLeagueRank.SupersonicLegend,
      },
    ],
  }, */
];
