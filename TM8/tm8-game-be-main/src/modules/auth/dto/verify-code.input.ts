import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, Max, Min } from 'class-validator';

export class VerifyCodeInput {
  @ApiProperty()
  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'Please provide a number' },
  )
  @Min(100000, { message: 'Verification code must be 6 digits long' })
  @Max(999999, { message: 'Verification code must be 6 digits long' })
  code: number;
}
