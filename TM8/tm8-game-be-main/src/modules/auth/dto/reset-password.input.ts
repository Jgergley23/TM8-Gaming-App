import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsEmail, IsOptional, Matches } from 'class-validator';

import { IsE164PhoneNumber } from 'src/common/decorators/phone-number.decorator';

export class ResetPasswordInput {
  @ApiPropertyOptional()
  @IsEmail({}, { message: 'Please provide a valid email' })
  @IsOptional()
  email?: string;

  @ApiPropertyOptional()
  @IsE164PhoneNumber({ message: 'Please provide a valid phone number' })
  @IsOptional()
  phoneNumber?: string;

  @ApiProperty()
  @Matches(
    /(?=^.{8,}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&amp;*()_+}{&quot;:;'?/&gt;.&lt;,])(?!.*\s).*$/,
    {
      message: 'Password not strong enough',
    },
  )
  password: string;
}
