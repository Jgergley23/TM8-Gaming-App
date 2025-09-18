import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import { IsEnum, IsOptional, IsString } from 'class-validator';

import { Role, UserStatusType } from 'src/common/constants';

export class ListUsersInput {
  @ApiPropertyOptional({
    description: 'Sorting parameters',
    type: String,
  })
  @Type(() => String)
  @IsString({ message: 'Sorting parameters must be in string format' })
  @IsOptional()
  sort = '-createdAt';

  @ApiProperty({
    description: 'User roles filter',
    type: [String],
    default: [Role.User],
  })
  @Transform(({ value }) => value.split(',').map((group) => group.trim()))
  @IsEnum(Role, {
    each: true,
    message: 'Input must be one of user roles',
  })
  @IsOptional()
  roles = [Role.User];

  @ApiPropertyOptional({
    description: 'Username filter',
    type: String,
  })
  @Type(() => String)
  @IsString({ message: 'Username search parameter must be in string format' })
  @IsOptional()
  username: string;

  @ApiPropertyOptional({
    description: 'Name filter',
    type: String,
  })
  @Type(() => String)
  @IsString({ message: 'Name search parameter must be in string format' })
  @IsOptional()
  name: string;

  @ApiPropertyOptional({
    description: 'Status filter',
    type: String,
    enum: UserStatusType,
    nullable: true,
  })
  @Type(() => String)
  @IsEnum(UserStatusType, { message: 'Input must be one of user statuses' })
  @IsOptional()
  status?: UserStatusType;
}
