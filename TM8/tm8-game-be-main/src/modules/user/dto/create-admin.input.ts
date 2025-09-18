import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, IsString, Matches } from 'class-validator';

export class CreateAdminInput {
  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  @Matches(/^[a-zA-Z]+(?: [a-zA-Z]+)+$/, {
    message: 'Full name must contain only letters',
  })
  fullName: string;

  @ApiProperty()
  @IsEmail()
  email: string;
}
