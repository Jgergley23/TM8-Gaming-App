import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as SchemaType } from 'mongoose';

import { Game } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { IMatchmakingResult } from '../interface/matchmaking-result.interface';

@Schema({ timestamps: true })
export class MatchmakingResult implements IMatchmakingResult {
  _id: string;

  @Prop({ enum: Game, required: true })
  game: Game;

  @Prop({ type: SchemaType.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;

  @Prop({ type: [SchemaType.Types.ObjectId], required: true, ref: 'User' })
  matches: string[] | User[];
}

export type MatchmakingResultDocument = HydratedDocument<MatchmakingResult>;
export const MatchmakingResultSchema = SchemaFactory.createForClass(
  MatchmakingResult,
).set('toJSON', {
  virtuals: true,
});
