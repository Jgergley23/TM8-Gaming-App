import { ApiProperty } from '@nestjs/swagger';

import { Gender, Role, SignupType } from 'src/common/constants';

import { IUserRecord } from '../interface/user.interface';
import { UserRatingResponse } from './user-rating.response';
import { UserStatusResponse } from './user-status.response';

export class UserResponse implements Partial<IUserRecord> {
  @ApiProperty()
  _id: string;

  @ApiProperty({ nullable: true })
  name?: string;

  @ApiProperty({ nullable: true })
  email?: string;

  @ApiProperty({ nullable: true })
  description?: string;

  @ApiProperty({ nullable: true })
  username?: string;

  @ApiProperty({ nullable: true })
  gender?: Gender;

  @ApiProperty({ nullable: true })
  role?: Role;

  @ApiProperty({ nullable: true })
  signupType?: SignupType;

  @ApiProperty({ nullable: true })
  timezone?: string;

  @ApiProperty({ nullable: true })
  country?: string;

  @ApiProperty({ nullable: true })
  note?: string;

  @ApiProperty({ nullable: true })
  photoKey?: string;

  @ApiProperty({ nullable: true })
  audioKey?: string;

  @ApiProperty({ nullable: true })
  phoneNumber?: string;

  @ApiProperty({ nullable: true })
  epicGamesUsername?: string;

  @ApiProperty({ nullable: true })
  phoneVerified?: boolean;

  @ApiProperty({ nullable: true })
  createdAt?: Date;

  @ApiProperty({ nullable: true })
  updatedAt?: Date;

  @ApiProperty({ nullable: true })
  dateOfBirth?: Date;

  @ApiProperty({ nullable: true })
  lastLogin?: Date;

  @ApiProperty({ type: UserStatusResponse, nullable: true })
  status?: UserStatusResponse;

  @ApiProperty({ nullable: true })
  rating?: UserRatingResponse;
}
