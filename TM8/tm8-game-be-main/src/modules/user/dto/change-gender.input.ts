import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsNotEmpty } from 'class-validator';

import { Gender } from 'src/common/constants';

export class ChangeGenderInput {
  @ApiProperty()
  @IsEnum(Gender, {
    message: `Please provide one of the values: ${Object.values(Gender)}`,
  })
  @IsNotEmpty({ message: 'Gender is required' })
  gender: string;
}
