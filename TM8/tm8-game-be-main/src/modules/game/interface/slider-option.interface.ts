import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

export interface ISliderOption {
  minValue: string;
  maxValue: string;
  attribute: GamePreferenceValue;
}
