import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

import { GamePreferenceQuestionType } from 'src/common/constants';

import { IGamePreferenceForm } from '../interface/game-preference-form.interface';
import { DropdownOptionResponse } from './dropdown-option.response';
import { SelectOptionResponse } from './select-option.response';
import { SliderOptionResponse } from './slider-option.response';

export class GamePreferenceInputResponse implements IGamePreferenceForm {
  @ApiProperty()
  title: string;

  @ApiProperty()
  type: GamePreferenceQuestionType;

  @ApiPropertyOptional({ type: [SliderOptionResponse] })
  sliderOptions?: SliderOptionResponse[];

  @ApiPropertyOptional({ type: [SelectOptionResponse] })
  selectOptions?: SelectOptionResponse[];

  @ApiPropertyOptional({ type: [DropdownOptionResponse] })
  dropdownOptions?: DropdownOptionResponse[];
}
