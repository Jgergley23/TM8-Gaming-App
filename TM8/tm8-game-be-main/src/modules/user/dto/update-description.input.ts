import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, MaxLength } from 'class-validator';

export class UpdateDescriptionInput {
  @ApiProperty()
  @IsString({ message: 'Please provide a description' })
  @MaxLength(100, {
    message: 'Description cannot be more than 100 characters long',
  })
  @IsNotEmpty({ message: 'Please provide a description' })
  description: string;
}
