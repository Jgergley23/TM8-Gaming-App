import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as SchemaTypes } from 'mongoose';

import { User } from 'src/modules/user/schemas/user.schema';

import {
  IFriendRecord,
  IFriendRequestRecord,
  IFriendsRecord,
} from '../interface/friends.interface';

@Schema({ timestamps: true })
export class Friend implements IFriendRecord {
  _id: string;

  @Prop({ type: SchemaTypes.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;
}

@Schema({ timestamps: true })
export class FriendRequest implements IFriendRequestRecord {
  _id: string;

  @Prop({ type: SchemaTypes.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;
}

@Schema()
export class Friends implements IFriendsRecord {
  _id: string;

  @Prop({ type: SchemaTypes.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;

  @Prop({ type: [Friend], required: false })
  friends: Friend[];

  @Prop({ type: [FriendRequest], required: false })
  requests: FriendRequest[];
}

export type FriendsDocument = HydratedDocument<Friends>;
export const FriendsSchema = SchemaFactory.createForClass(Friends).set(
  'toJSON',
  {
    virtuals: true,
  },
);
