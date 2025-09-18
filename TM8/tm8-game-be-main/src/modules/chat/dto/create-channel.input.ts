import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId, IsNotEmpty, IsString } from 'class-validator';

export class CreateChannelInput {
  @ApiProperty()
  @IsString({ each: true, message: 'Please provide a string input' })
  @IsMongoId({ each: true, message: 'Please provide valid Object IDs' })
  @IsNotEmpty()
  members: string[];

  owner: string;
}
