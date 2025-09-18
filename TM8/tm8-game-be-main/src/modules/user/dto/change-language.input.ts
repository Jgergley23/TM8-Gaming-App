import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class ChangeLanguageInput {
  @ApiProperty()
  @IsString({ message: 'Please provide a valid language' })
  @IsNotEmpty({ message: 'Language is required' })
  language: string;
}
