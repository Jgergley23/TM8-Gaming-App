import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

import { IsE164PhoneNumber } from 'src/common/decorators/phone-number.decorator';

export class PhoneVerificationInput {
  @ApiProperty()
  @IsString({ message: 'Please provide a phone number' })
  @IsNotEmpty({ message: 'Please provide a phone number' })
  @IsE164PhoneNumber({ message: 'Please provide a valid phone number' })
  phoneNumber: string;
}
