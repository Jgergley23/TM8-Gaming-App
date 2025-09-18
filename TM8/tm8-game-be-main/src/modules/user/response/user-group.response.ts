import { ApiProperty } from '@nestjs/swagger';

import { UserGroup } from 'src/common/constants';
import { IUserGroup } from 'src/common/interfaces/user-group.interface';

export class UserGroupResponse implements IUserGroup {
  @ApiProperty({ enum: UserGroup })
  key: UserGroup;

  @ApiProperty()
  name: string;
}
