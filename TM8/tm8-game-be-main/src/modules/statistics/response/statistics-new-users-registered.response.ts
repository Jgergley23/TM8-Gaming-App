import { ApiProperty } from '@nestjs/swagger';

import { NewUsersRegisteredObjectResponse } from './new-users-registered-object.response';

export class StatisticsNewUsersRegisteredResponse {
  @ApiProperty()
  chart: NewUsersRegisteredObjectResponse[];
}
