import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as SchemaType } from 'mongoose';

import { ActionType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { IActionRecord } from '../interfaces/action.interface';
import { ActionData } from './action-data.schema';

@Schema({ timestamps: true })
export class Action implements IActionRecord {
  _id: string;

  @Prop({
    type: [ActionData],
    required: true,
  })
  actionsFrom: ActionData[];

  @Prop({
    type: [ActionData],
    required: true,
  })
  actionsTo: ActionData[];

  @Prop({
    enum: ActionType,
    required: true,
  })
  actionType: ActionType;

  @Prop({ type: SchemaType.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;
}

export type ActionDocument = HydratedDocument<Action>;
export const ActionSchema = SchemaFactory.createForClass(Action).set('toJSON', {
  virtuals: true,
});
