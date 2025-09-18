import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, Matches } from 'class-validator';

export class ChangePasswordInput {
  @ApiProperty()
  oldPassword: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty({ message: 'Please provide a password' })
  @Matches(
    /(?=^.{8,}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&amp;*()_+}{&quot;:;'?/&gt;.&lt;,])(?!.*\s).*$/,
    {
      message: 'Password not strong enough',
    },
  )
  newPassword: string;
}
