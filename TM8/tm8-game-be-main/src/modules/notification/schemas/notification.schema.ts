import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as SchemaType } from 'mongoose';

import {
  DEFAULT_MAX_LENGTH,
  DEFAULT_MIN_LENGTH,
  UserNotificationType,
} from 'src/common/constants';
import { ScheduledNotification } from 'src/modules/scheduled-notification/schemas/scheduled-notification.schema';
import { User } from 'src/modules/user/schemas/user.schema';

import {
  INotificationDataRecord,
  INotificationRecord,
} from '../interfaces/notification.interface';

@Schema()
export class NotificationData implements INotificationDataRecord {
  _id: string;

  @Prop({ required: true, default: false, type: Boolean })
  isRead: boolean;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: true,
  })
  title: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: true,
  })
  description: string;

  @Prop({
    type: String,
    enum: Object.values(UserNotificationType),
    required: true,
  })
  notificationType: UserNotificationType;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
  })
  redirectScreen?: string;
}

@Schema({ timestamps: true })
export class Notification implements INotificationRecord {
  _id: string;

  @Prop({ type: SchemaType.Types.ObjectId, required: true, ref: 'User' })
  user: string | User;

  @Prop({ type: Date, required: true })
  since: Date;

  @Prop({ type: Date, required: true })
  until: Date;

  @Prop({ type: NotificationData })
  data: NotificationData;

  @Prop({
    type: SchemaType.Types.ObjectId,
    required: false,
    ref: 'ScheduledNotification',
  })
  scheduledNotification?: string | ScheduledNotification;
}

export type NotificationDocument = HydratedDocument<Notification>;
export const NotificationSchema = SchemaFactory.createForClass(
  Notification,
).set('toJSON', {
  virtuals: true,
});

export type NotificationDataDocument = HydratedDocument<NotificationData>;
export const NotificationDataSchema = SchemaFactory.createForClass(
  NotificationData,
).set('toJSON', {
  virtuals: true,
});
