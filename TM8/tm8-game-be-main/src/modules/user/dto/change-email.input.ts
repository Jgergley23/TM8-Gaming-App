import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty } from 'class-validator';

export class ChangeEmailInput {
  @ApiProperty()
  @IsEmail({}, { message: 'Please provide a valid email' })
  @IsNotEmpty({ message: 'Please provide an email' })
  email: string;
}
