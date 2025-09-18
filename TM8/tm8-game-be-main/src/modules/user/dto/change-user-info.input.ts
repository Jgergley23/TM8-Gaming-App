import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsEnum, IsIn, IsOptional, IsString, MaxLength } from 'class-validator';

import { Gender } from 'src/common/constants';
import { Region } from 'src/common/constants/region.enum';
import { IsOlderThanThirteen } from 'src/common/decorators/is-older-than-thirteen.decorator';
import { IsValidDate } from 'src/common/decorators/is-valid-date.decorator';

export const regionOptions = Object.values(Region);

export class ChangeUserInfoInput {
  @ApiPropertyOptional()
  @IsString({ message: 'Please provide a valid country' })
  @IsOptional()
  country?: string;

  @ApiPropertyOptional()
  @IsValidDate()
  @IsOlderThanThirteen({
    message: 'You must be at least 13 years old',
  })
  @IsOptional()
  dateOfBirth?: string;

  @ApiPropertyOptional()
  @IsEnum(Gender, {
    message: `Please provide one of the values: ${Object.values(Gender)}`,
  })
  @IsOptional()
  gender?: string;

  @ApiPropertyOptional()
  @IsIn(Object.values(Region), {
    each: true,
    message: `Please provide at least one of the values: ${Object.values(
      Region,
    )}`,
  })
  @IsOptional()
  regions?: string[];

  @ApiPropertyOptional()
  @IsString({ message: 'Please provide a valid language' })
  @IsOptional()
  language?: string;

  @ApiPropertyOptional()
  @IsString({ message: 'Please provide a description' })
  @MaxLength(100, {
    message: 'Description cannot be more than 100 characters long',
  })
  @IsOptional()
  description?: string;
}
