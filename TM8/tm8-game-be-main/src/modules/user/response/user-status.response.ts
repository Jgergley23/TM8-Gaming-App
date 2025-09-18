import { ApiProperty } from '@nestjs/swagger';

import { UserStatusType } from 'src/common/constants/user-status-type.enum';

export class UserStatusResponse {
  @ApiProperty()
  type: UserStatusType;

  @ApiProperty()
  note?: string;

  @ApiProperty()
  until?: Date;
}
