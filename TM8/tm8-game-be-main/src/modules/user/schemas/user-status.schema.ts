import { Prop } from '@nestjs/mongoose';

import { UserStatusType } from 'src/common/constants/user-status-type.enum';

export class UserStatus {
  @Prop({
    type: String,
    enum: Object.values(UserStatusType),
    default: UserStatusType.Active,
    required: true,
  })
  type: UserStatusType;

  @Prop({ type: String, default: '', required: false })
  note?: string;

  @Prop({ type: Date, default: null, required: false })
  until?: Date;
}
