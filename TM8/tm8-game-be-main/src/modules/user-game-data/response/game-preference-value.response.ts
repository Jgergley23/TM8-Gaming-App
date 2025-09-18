import { ApiProperty } from '@nestjs/swagger';

import { IGamePreferenceValue } from '../interface/game-preference-value.interface';

export class GamePreferenceValueResponse implements IGamePreferenceValue {
  @ApiProperty()
  key: string;
  @ApiProperty()
  selectedValue?: string;
  @ApiProperty()
  numericValue?: number;
  @ApiProperty()
  numericDisplay?: string;
}
