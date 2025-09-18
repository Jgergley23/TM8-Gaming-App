import { ApiProperty } from '@nestjs/swagger';

export class NewUsersRegisteredObjectResponse {
  @ApiProperty()
  date: string;

  @ApiProperty()
  quantity: number;
}
