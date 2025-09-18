import { ApiPropertyOptional } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsEnum, IsOptional } from 'class-validator';

import { UserGroup } from 'src/common/constants';

export class GetUserGroupCountsParams {
  @ApiPropertyOptional({
    description: 'User group filter',
    type: String,
    nullable: true,
  })
  @Transform(({ value }) => value.split(',').map((group) => group.trim()))
  @IsEnum(UserGroup, {
    each: true,
    message: 'Input must be one of user groups',
  })
  @IsOptional()
  userGroups?: string[];
}
