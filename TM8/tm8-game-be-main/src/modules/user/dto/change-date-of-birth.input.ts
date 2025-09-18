import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';

import { IsOlderThanThirteen } from 'src/common/decorators/is-older-than-thirteen.decorator';
import { IsValidDate } from 'src/common/decorators/is-valid-date.decorator';

export class ChangeDateOfBirthInput {
  @ApiProperty()
  @IsValidDate()
  @IsOlderThanThirteen({
    message: 'You must be at least 13 years old',
  })
  @IsNotEmpty({ message: 'Please provide a date of birth' })
  dateOfBirth: string;
}
