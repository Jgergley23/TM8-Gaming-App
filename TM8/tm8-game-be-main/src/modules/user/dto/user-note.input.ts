import { ApiProperty } from '@nestjs/swagger';
import { IsString, MaxLength } from 'class-validator';

export class UserNoteInput {
  @ApiProperty()
  @IsString({ message: 'Please provide a note' })
  @MaxLength(150, { message: 'Note can be maximum 150 characters long' })
  note: string;
}
