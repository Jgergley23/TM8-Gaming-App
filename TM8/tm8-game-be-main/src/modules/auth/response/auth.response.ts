import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

import { IAuth } from '../interface/auth.interface';

export class AuthResponse implements IAuth {
  @ApiPropertyOptional()
  accessToken?: string;

  @ApiPropertyOptional()
  phoneVerificationRequired?: boolean;

  @ApiPropertyOptional()
  refreshToken?: string;

  @ApiProperty()
  success: boolean;

  @ApiPropertyOptional()
  username?: string;

  @ApiPropertyOptional()
  name?: string;

  @ApiPropertyOptional()
  role?: string;

  @ApiPropertyOptional()
  id?: string;

  @ApiPropertyOptional()
  signupType?: string;

  @ApiPropertyOptional()
  chatToken?: string;

  @ApiProperty({ type: Date, nullable: true })
  dateOfBirth?: Date | null;
}
