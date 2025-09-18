import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as SchemaType } from 'mongoose';

import { Game, UserMatchChoice } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import {
  IPotentialMatch,
  IPotentialMatchUser,
} from '../interface/potential-match.interface';

@Schema()
export class PotentialMatchUser implements IPotentialMatchUser {
  _id: string;

  @Prop({ type: SchemaType.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;

  @Prop({
    enum: UserMatchChoice,
    required: true,
    default: UserMatchChoice.None,
  })
  choice: UserMatchChoice;
}

@Schema({ timestamps: true })
export class PotentialMatch implements IPotentialMatch {
  _id: string;

  @Prop({ enum: Game, required: true })
  game: Game;

  @Prop({
    type: [PotentialMatchUser],
    default: [],
    required: true,
  })
  users: PotentialMatchUser[];
}

export type PotentialMatchDocument = HydratedDocument<PotentialMatch>;
export const PotentialMatchSchema = SchemaFactory.createForClass(
  PotentialMatch,
).set('toJSON', {
  virtuals: true,
});
