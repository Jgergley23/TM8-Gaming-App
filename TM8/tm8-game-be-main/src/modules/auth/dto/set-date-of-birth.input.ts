import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';

import { IsOlderThanThirteen } from 'src/common/decorators/is-older-than-thirteen.decorator';
import { IsValidDate } from 'src/common/decorators/is-valid-date.decorator';

export class SetDateOfBirthInput {
  @ApiProperty()
  @IsValidDate()
  @IsOlderThanThirteen({
    message: 'You must be at least 13 years old to register',
  })
  @IsNotEmpty({ message: 'Please provide a date of birth' })
  dateOfBirth: string;
}
