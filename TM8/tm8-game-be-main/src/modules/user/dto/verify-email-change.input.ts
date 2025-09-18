import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, MaxLength, MinLength } from 'class-validator';

export class VerifyEmailChangeInput {
  @ApiProperty()
  @IsString({ message: 'Code must be a string' })
  @MaxLength(7, { message: 'Code must be 7 characters long' })
  @MinLength(7, { message: 'Code must be 7 characters long' })
  @IsNotEmpty({ message: 'Code is required' })
  code: string;
}
