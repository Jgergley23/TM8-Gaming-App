import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

@Schema()
export class UserRating {
  @Prop({ type: [Number], default: [], required: true })
  ratings: number[];

  @Prop({ type: Number, default: 0, required: true })
  average: number;
}

export type UserRatingDocument = HydratedDocument<UserRating>;
export const UserRatingSchema = SchemaFactory.createForClass(UserRating).set(
  'toJSON',
  {
    virtuals: true,
  },
);
