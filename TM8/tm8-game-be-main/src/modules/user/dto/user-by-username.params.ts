import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsNotEmpty, IsString } from 'class-validator';

export class GetUserByUsernameParams {
  @ApiProperty({
    name: 'username',
    description: 'Username',
    type: String,
  })
  @Transform(({ value }) => value.trim())
  @IsString({ message: 'Username should be a string' })
  @IsNotEmpty({ message: 'Username should not be empty' })
  username: string;
}
