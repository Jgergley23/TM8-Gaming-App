import { ApiProperty } from '@nestjs/swagger';

import { WarningReason } from 'src/common/constants';
import { IUserWarningType } from 'src/common/interfaces/user-warning-type.interface';

export class UserWarningTypeResponse implements IUserWarningType {
  @ApiProperty({ enum: WarningReason })
  key: WarningReason;

  @ApiProperty()
  name: string;
}
