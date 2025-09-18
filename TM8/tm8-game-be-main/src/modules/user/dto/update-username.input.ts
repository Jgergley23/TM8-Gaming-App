import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, MaxLength } from 'class-validator';

import { USERNAME_MAX_LENGTH } from 'src/common/constants/user-info';

export class UpdateUsernameInput {
  @ApiProperty()
  @IsString({ message: 'Please provide a username' })
  @MaxLength(USERNAME_MAX_LENGTH, {
    message: 'Username cannot be more than 16 characters long',
  })
  @IsNotEmpty({ message: 'Please provide a username' })
  username: string;
}
