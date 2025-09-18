import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class ChangeCountryInput {
  @ApiProperty()
  @IsString({ message: 'Please provide a valid country' })
  @IsNotEmpty({ message: 'Country is required' })
  country: string;
}
