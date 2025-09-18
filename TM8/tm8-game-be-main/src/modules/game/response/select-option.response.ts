import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';

import { ISelectOption } from '../interface/select-option.interface';
import { GamePreferenceInputResponse } from './game-preference-input.response';

export class SelectOptionResponse implements ISelectOption {
  @ApiProperty()
  display: string;

  @ApiProperty()
  attribute: GamePreferenceValue;

  @ApiPropertyOptional({ type: GamePreferenceInputResponse })
  cascade?: GamePreferenceInputResponse;
}
