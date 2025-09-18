import { ApiProperty, getSchemaPath } from '@nestjs/swagger';

import { Game } from 'src/common/constants';
import { UserResponse } from 'src/modules/user/response/user.response';
import { User } from 'src/modules/user/schemas/user.schema';

import { IUserGameDataRecord } from '../interface/user-game-data.interface';
import { GamePreferenceResponse } from './game-preference.response';

export class UserGameDataResponse implements IUserGameDataRecord {
  @ApiProperty()
  _id: string;

  @ApiProperty({
    oneOf: [
      { type: 'string' },
      {
        type: getSchemaPath(UserResponse),
      },
    ],
  })
  user: string | User;

  @ApiProperty()
  game: Game;

  @ApiProperty({
    type: [GamePreferenceResponse],
  })
  preferences: GamePreferenceResponse[];
}
