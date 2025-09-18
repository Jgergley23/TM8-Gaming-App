import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class AuthLoginInput {
  @ApiProperty()
  @IsString({ message: 'Email should be a text value' })
  @IsNotEmpty({ message: 'Please provide an email' })
  @IsEmail({}, { message: 'Please provide a valid email' })
  email: string;

  @ApiProperty()
  @IsString({ message: 'Password should be a text value' })
  @IsNotEmpty({ message: 'Please provide a password' })
  password: string;

  @ApiPropertyOptional()
  @IsString({ message: 'Notification token should be a text value' })
  @IsOptional()
  notificationToken?: string;
}
