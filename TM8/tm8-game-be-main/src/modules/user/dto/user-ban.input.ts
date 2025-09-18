import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId, IsNotEmpty, IsString, MaxLength } from 'class-validator';

export class UserBanInput {
  @ApiProperty()
  @IsMongoId({ each: true, message: 'Please provide a valid user id' })
  userIds: string[];

  @ApiProperty()
  @IsString({ message: 'Please provide a note' })
  @IsNotEmpty({ message: 'Note cannot be empty' })
  @MaxLength(60, { message: 'Note can be maximum 60 characters long' })
  note: string;
}
