import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty } from 'class-validator';

import { IsE164PhoneNumber } from 'src/common/decorators/phone-number.decorator';

export class SetUserPhoneInput {
  @ApiProperty()
  @IsEmail({}, { message: 'Please provide a valid email' })
  @IsNotEmpty({ message: 'Please provide an email' })
  email: string;

  @ApiProperty()
  @IsE164PhoneNumber({ message: 'Please provide a vaild phone number' })
  @IsNotEmpty({ message: 'Please provide a phone number' })
  phoneNumber: string;
}
