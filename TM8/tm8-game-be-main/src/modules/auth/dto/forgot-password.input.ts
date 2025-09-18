import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsEmail, IsOptional } from 'class-validator';

import { IsE164PhoneNumber } from 'src/common/decorators/phone-number.decorator';

export class ForgotPasswordInput {
  @ApiPropertyOptional()
  @IsEmail({}, { message: 'Please provide a valid email' })
  @IsOptional()
  email?: string;

  @ApiPropertyOptional()
  @IsE164PhoneNumber({ message: 'Please provide a valid phone number' })
  @IsOptional()
  phoneNumber?: string;
}
