import { ApiProperty } from '@nestjs/swagger';

import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

import { ISliderOption } from '../interface/slider-option.interface';

export class SliderOptionResponse implements ISliderOption {
  @ApiProperty()
  minValue: string;

  @ApiProperty()
  maxValue: string;

  @ApiProperty()
  attribute: GamePreferenceValue;
}
