import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as SchemaType } from 'mongoose';

import { Game } from 'src/common/constants/game.enum';
import { User } from 'src/modules/user/schemas/user.schema';

import { IUserGameData } from '../interface/user-game-data.interface';
import { UserGamePreference } from './user-game-preference.schema';

@Schema()
export class UserGameData implements IUserGameData {
  _id: string;

  @Prop({ enum: Game, required: true })
  game: Game;

  @Prop({ type: SchemaType.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;

  @Prop({
    type: [UserGamePreference],
    default: [],
    required: true,
  })
  preferences: UserGamePreference[];
}

export type UserGameDataDocument = HydratedDocument<UserGameData>;
export const UserGameDataSchema = SchemaFactory.createForClass(
  UserGameData,
).set('toJSON', {
  virtuals: true,
});
