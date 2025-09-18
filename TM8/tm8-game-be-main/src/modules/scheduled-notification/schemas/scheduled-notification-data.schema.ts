import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

import {
  DEFAULT_MAX_LENGTH,
  DEFAULT_MIN_LENGTH,
  UserGroup,
  UserNotificationType,
} from 'src/common/constants';

import { IScheduledNotificationDataRecord } from '../interfaces/scheduled-notification-data.interface';

@Schema({ timestamps: true })
export class ScheduledNotificationData
  implements IScheduledNotificationDataRecord
{
  @Prop({ enum: UserGroup, required: true })
  targetGroup: UserGroup;

  @Prop({ enum: UserNotificationType, required: true })
  notificationType: UserNotificationType;

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
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
  })
  redirectScreen?: string;
}

export type ScheduledNotificationDataDocument =
  HydratedDocument<ScheduledNotificationData>;
export const ScheduledNotificationDataSchema = SchemaFactory.createForClass(
  ScheduledNotificationData,
).set('toJSON', {
  virtuals: true,
});
