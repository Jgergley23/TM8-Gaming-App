import { Prop } from '@nestjs/mongoose';

export class UserNotificationSettings {
  @Prop({
    type: Boolean,
    default: true,
  })
  enabled: boolean;

  @Prop({
    type: Boolean,
    default: true,
  })
  match: boolean;

  @Prop({
    type: Boolean,
    default: true,
  })
  message: boolean;

  @Prop({
    type: Boolean,
    default: true,
  })
  friendAdded: boolean;

  @Prop({
    type: Boolean,
    default: true,
  })
  news: boolean;

  @Prop({
    type: Boolean,
    default: true,
  })
  reminders: boolean;
}
