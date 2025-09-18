import { Game } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

export interface IMatchmakingResult {
  user: string | User;
  game: Game;
  matches: string[] | User[];
}

export interface IMatchmakingResultRecord extends IMatchmakingResult {
  _id: string;
  createdAt?: Date;
  updatedAt?: Date;
}
