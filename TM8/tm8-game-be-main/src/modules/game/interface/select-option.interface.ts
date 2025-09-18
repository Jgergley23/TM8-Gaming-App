import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

import { IGamePreferenceForm } from './game-preference-form.interface';

export interface ISelectOption {
  display: string;
  attribute: GamePreferenceValue;
  cascade?: IGamePreferenceForm;
}
