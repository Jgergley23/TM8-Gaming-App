import { GamePreferenceQuestionType } from 'src/common/constants';

import { IDropdownOption } from './dropdown-option.interface';
import { ISelectOption } from './select-option.interface';
import { ISliderOption } from './slider-option.interface';

export interface IGamePreferenceForm {
  title: string;
  type: GamePreferenceQuestionType;
  selectOptions?: ISelectOption[];
  sliderOptions?: ISliderOption[];
  dropdownOptions?: IDropdownOption[];
}
