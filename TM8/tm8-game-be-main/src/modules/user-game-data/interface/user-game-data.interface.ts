import { Game } from 'src/common/constants/game.enum';
import { User } from 'src/modules/user/schemas/user.schema';

import { IUserGamePreference } from './user-game-preference.interface';

export interface IUserGameData {
  game: Game;
  user: string | User;
  preferences: IUserGamePreference[];
}

export interface IUserGameDataRecord extends IUserGameData {
  _id: string;
}
