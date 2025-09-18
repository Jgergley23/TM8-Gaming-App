import { Prop } from '@nestjs/mongoose';
import { Schema as SchemaType } from 'mongoose';

import { Game } from 'src/common/constants';

import { User } from './user.schema';

export class RejectedUser {
  @Prop({ type: SchemaType.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;

  @Prop({ enum: Game, required: true })
  game: Game;

  @Prop({ type: Date, required: true })
  until: Date;
}
