import { Game } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

export interface IPotentialMatchUser {
  user: string | User;
}

export interface IPotentialMatch {
  game: Game;
  users: IPotentialMatchUser[];
}

export interface IPotentialMatchRecord extends IPotentialMatch {
  _id: string;
  createdAt?: Date;
  updatedAt?: Date;
}
