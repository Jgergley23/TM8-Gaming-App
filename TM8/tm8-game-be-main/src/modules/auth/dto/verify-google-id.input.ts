import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, MaxLength } from 'class-validator';

export class VerifyGoogleIdInput {
  @ApiProperty()
  @IsString({ message: 'Please provide a Google access token' })
  @IsNotEmpty({ message: 'Token cannot be empty' })
  token: string;

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
