import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsEmail,
  IsJWT,
  IsNotEmpty,
  IsOptional,
  IsString,
  MaxLength,
} from 'class-validator';

export class VerifyAppleIdInput {
  @ApiProperty()
  @IsJWT()
  @IsNotEmpty({ message: 'Please provide a valid token' })
  token: string;

  @ApiPropertyOptional()
  @IsEmail({}, { message: 'Please provide a valid email' })
  @IsOptional()
  email?: string;

  @ApiPropertyOptional()
  @IsString({ message: 'Please provide a full name' })
  @MaxLength(50, {
    message: 'Full name cannot be more than 50 characters long',
  })
  @IsOptional()
  fullName?: string;

  @ApiPropertyOptional()
  @IsString({ message: 'Notification token should be a text value' })
  @IsOptional()
  notificationToken?: string;
}
