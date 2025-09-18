import { ApiProperty } from '@nestjs/swagger';

import { IGamePreference } from '../interface/game-preference.interface';
import { GamePreferenceValueResponse } from './game-preference-value.response';

export class GamePreferenceResponse implements IGamePreference {
  @ApiProperty()
  key: string;

  @ApiProperty({
    type: [GamePreferenceValueResponse],
  })
  values: GamePreferenceValueResponse[];

  @ApiProperty()
  title: string;
}
