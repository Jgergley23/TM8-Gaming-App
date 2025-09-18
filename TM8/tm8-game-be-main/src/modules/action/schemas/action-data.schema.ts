import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as SchemaType } from 'mongoose';

import { ReportReason } from 'src/common/constants/report-reason.enum';
import { User } from 'src/modules/user/schemas/user.schema';

import { IActionDataRecord } from '../interfaces/action-data.interface';

@Schema({ timestamps: true })
export class ActionData implements IActionDataRecord {
  @Prop({
    enum: ReportReason,
    required: false,
  })
  reportReason?: ReportReason;

  @Prop({ type: SchemaType.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;
}

export type ActionDataDocument = HydratedDocument<ActionData>;
export const ActionDataSchema = SchemaFactory.createForClass(ActionData).set(
  'toJSON',
  {
    virtuals: true,
  },
);
