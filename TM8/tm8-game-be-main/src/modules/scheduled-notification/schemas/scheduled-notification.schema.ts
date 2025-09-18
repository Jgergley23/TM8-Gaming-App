import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as SchemaType } from 'mongoose';

import { UserNotificationInterval } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { IScheduledNotificationRecord } from '../interfaces/scheduled-notification.interface';
import { ScheduledNotificationData } from './scheduled-notification-data.schema';

@Schema({ timestamps: true })
export class ScheduledNotification implements IScheduledNotificationRecord {
  _id: string;

  @Prop({ type: Date, required: true })
  date: Date;

  @Prop({
    enum: UserNotificationInterval,
    required: true,
  })
  interval: UserNotificationInterval;

  @Prop({
    type: Number,
    required: true,
    default: 0,
  })
  receivedBy: number;

  @Prop({
    type: Number,
    required: true,
    default: 0,
  })
  openedBy: number;

  @Prop({
    type: String,
    required: true,
    minlength: 7,
    maxlength: 7,
    unique: true,
  })
  uniqueId: string;

  @Prop({ type: [SchemaType.Types.ObjectId], required: true, ref: 'User' })
  users: string[] | User[];

  @Prop({ type: ScheduledNotificationData, required: true })
  data: ScheduledNotificationData;
}

export type ScheduledNotificationDocument =
  HydratedDocument<ScheduledNotification>;
export const ScheduledNotificationSchema = SchemaFactory.createForClass(
  ScheduledNotification,
).set('toJSON', {
  virtuals: true,
});
