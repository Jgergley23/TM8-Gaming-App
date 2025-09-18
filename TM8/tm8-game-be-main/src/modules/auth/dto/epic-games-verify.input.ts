import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId, IsNotEmpty, IsString } from 'class-validator';

export class EpicGamesVerifyInput {
  @ApiProperty()
  @IsString({ message: 'Please provide a valid code' })
  @IsNotEmpty({ message: 'Please provide a code' })
  code: string;

  @ApiProperty()
  @IsMongoId({ message: 'Please provide a valid user ID' })
  @IsNotEmpty({ message: 'Please provide a user ID' })
  userId: string;
}
