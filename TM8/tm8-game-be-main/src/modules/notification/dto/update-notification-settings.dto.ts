import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsOptional } from 'class-validator';

export class UpdateNotificationSettingsDto {
  @ApiProperty()
  @IsBoolean()
  @IsOptional()
  enabled?: boolean;

  @ApiProperty()
  @IsBoolean()
  @IsOptional()
  match?: boolean;

  @ApiProperty()
  @IsBoolean()
  @IsOptional()
  friendAdded?: boolean;

  @ApiProperty()
  @IsBoolean()
  @IsOptional()
  message?: boolean;

  @ApiProperty()
  @IsBoolean()
  @IsOptional()
  reminders?: boolean;

  @ApiProperty()
  @IsBoolean()
  @IsOptional()
  news?: boolean;
}
