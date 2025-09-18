import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

import { Gender, Region, Role, SignupType } from 'src/common/constants';
import {
  DEFAULT_MAX_LENGTH,
  DEFAULT_MIN_LENGTH,
} from 'src/common/constants/constraints';
import { CryptoUtils } from 'src/common/utils/crypto.utils';

import { IUserRecord } from '../interface/user.interface';
import { UserNotificationSettings } from './user-notification-settings.schema';
import { UserRating } from './user-rating.schema';
import { RejectedUser } from './user-rejected-user.schema';
import { UserStatus } from './user-status.schema';

@Schema({ timestamps: true })
export class User implements IUserRecord {
  _id: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
  })
  name?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    sparse: true,
    required: false,
    unique: true,
  })
  username?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    sparse: true,
    required: false,
    unique: true,
  })
  epicGamesUsername?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: true,
    unique: true,
  })
  email: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
    sparse: true,
    unique: true,
  })
  newEmail?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
    sparse: true,
    unique: true,
  })
  emailChangeCode?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
    sparse: true,
    unique: true,
  })
  appleSub?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
    sparse: true,
    unique: true,
  })
  googleSub?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    unique: true,
    sparse: true,
    required: false,
  })
  phoneNumber?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
    select: false,
  })
  password?: string;

  @Prop({
    enum: Role,
    required: true,
  })
  role: Role;

  @Prop({
    enum: Gender,
    required: false,
  })
  gender?: Gender;

  @Prop({
    enum: SignupType,
    required: false,
  })
  signupType?: SignupType;

  @Prop({
    type: String,
    required: false,
  })
  timezone?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
  })
  country?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
  })
  photoKey?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
  })
  audioKey?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
  })
  note?: string;

  @Prop({ type: Date, required: false })
  dateOfBirth?: Date;

  @Prop({ type: Number, required: false })
  verificationCode?: number;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
    select: false,
  })
  refreshToken?: string;

  @Prop({ type: Boolean, required: false })
  resetPasswordRequested?: boolean;

  @Prop({ type: Boolean, required: false })
  verifyPhoneRequested?: boolean;

  @Prop({ type: Boolean, required: false })
  resetEmailRequested?: boolean;

  @Prop({ type: Boolean, required: false })
  changeEmailRequested?: boolean;

  @Prop({ type: Boolean, required: false })
  resetPasswordConfirmed?: boolean;

  @Prop({ type: Boolean, required: false })
  phoneVerified?: boolean;

  @Prop({ type: UserStatus, required: true })
  status: UserStatus;

  @Prop({ type: UserNotificationSettings, required: true })
  notificationSettings: UserNotificationSettings;

  @Prop({ type: Date, required: false })
  lastLogin?: Date;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    sparse: true,
    required: false,
    unique: true,
  })
  chatToken?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
  })
  description?: string;

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
  })
  language?: string;

  @Prop({
    enum: Region,
    required: false,
    type: [String],
  })
  regions?: Region[];

  @Prop({
    type: String,
    minLength: DEFAULT_MIN_LENGTH,
    maxlength: DEFAULT_MAX_LENGTH,
    required: false,
  })
  notificationToken?: string;

  @Prop({ type: RejectedUser, required: false })
  rejectedUsers?: RejectedUser[];

  @Prop({ type: UserRating, required: false })
  rating?: UserRating;
}

export type UserDocument = HydratedDocument<User>;
export const UserSchema = SchemaFactory.createForClass(User).set('toJSON', {
  virtuals: true,
});

UserSchema.pre<UserDocument>('save', async function (next) {
  if (this.isModified('password')) {
    try {
      const hashedPassword = await CryptoUtils.generateHash(this.password, 10);
      this.password = hashedPassword;
      next();
    } catch (err) {
      return next(err);
    }
  } else if (this.isModified('rating.ratings')) {
    try {
      const totalRatings = this.rating.ratings.length;
      if (totalRatings === 0) {
        this.rating.average = 0;
      } else {
        const sumOfRatings = this.rating.ratings.reduce(
          (acc, cur) => acc + cur,
          0,
        );
        this.rating.average = Number((sumOfRatings / totalRatings).toFixed(1));
      }
      next();
    } catch (err) {
      return next(err);
    }
  }
  return next();
});
