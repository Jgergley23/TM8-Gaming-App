import { Game } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

export interface IMatchPlayer {
  user: string | User;
  feedback: number;
}

export interface IMatch {
  game: Game;
  players: IMatchPlayer[];
}

export interface IMatchRecord extends IMatch {
  _id: string;
  createdAt?: Date;
  updatedAt?: Date;
}

export interface IMatchPlayerRecord extends IMatchPlayer {
  _id: string;
  createdAt?: Date;
  updatedAt?: Date;
}
