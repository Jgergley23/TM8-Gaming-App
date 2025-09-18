import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as SchemaType } from 'mongoose';

import { Game } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { IMatch, IMatchPlayer } from '../interface/match.interface';

@Schema({ timestamps: true })
export class MatchPlayer implements IMatchPlayer {
  _id: string;

  @Prop({ type: SchemaType.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;

  @Prop({ type: Number, required: false })
  feedback: number;
}

@Schema({ timestamps: true })
export class Match implements IMatch {
  _id: string;

  @Prop({ enum: Game, required: true })
  game: Game;

  @Prop({
    type: [MatchPlayer],
    default: [],
    required: true,
  })
  players: MatchPlayer[];
}

export type MatchDocument = HydratedDocument<Match>;
export const MatchSchema = SchemaFactory.createForClass(Match).set('toJSON', {
  virtuals: true,
});

export type MatchPlayerDocument = HydratedDocument<MatchPlayer>;
export const MatchPlayerSchema = SchemaFactory.createForClass(MatchPlayer).set(
  'toJSON',
  {
    virtuals: true,
  },
);
