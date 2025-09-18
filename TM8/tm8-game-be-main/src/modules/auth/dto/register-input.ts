import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsEmail,
  IsNotEmpty,
  IsOptional,
  IsString,
  Matches,
  MaxLength,
} from 'class-validator';

import { USERNAME_MAX_LENGTH } from 'src/common/constants/user-info';
import { IsOlderThanThirteen } from 'src/common/decorators/is-older-than-thirteen.decorator';
import { IsTimezone } from 'src/common/decorators/is-timezone.decorator';
import { IsValidDate } from 'src/common/decorators/is-valid-date.decorator';

export class RegisterInput {
  @ApiProperty()
  @IsEmail({}, { message: 'Please provide a vaild email' })
  @IsNotEmpty({ message: 'Please provide an email' })
  email: string;

  @ApiProperty()
  @IsString({ message: 'Please provide a username' })
  @MaxLength(USERNAME_MAX_LENGTH, {
    message: 'Username cannot be more than 16 characters long',
  })
  @IsNotEmpty({ message: 'Please provide a username' })
  username: string;

  @ApiProperty()
  @IsValidDate()
  @IsOlderThanThirteen({
    message: 'You must be at least 13 years old to register',
  })
  @IsNotEmpty({ message: 'Please provide a date of birth' })
  dateOfBirth: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty({ message: 'Please provide a password' })
  @Matches(
    /(?=^.{8,}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&amp;*()_+}{&quot;:;'?/&gt;.&lt;,])(?!.*\s).*$/,
    {
      message: 'Password not strong enough',
    },
  )
  password: string;

  @ApiPropertyOptional()
  @IsTimezone({
    message: 'Please provide a valid timezone in format ABC±XX',
  })
  @IsOptional()
  timezone?: string;

  @ApiPropertyOptional()
  @IsString({ message: 'Please provide a country' })
  @IsOptional()
  country?: string;

  @ApiPropertyOptional()
  @IsString({ message: 'Notification token should be a text value' })
  @IsOptional()
  notificationToken?: string;
}
