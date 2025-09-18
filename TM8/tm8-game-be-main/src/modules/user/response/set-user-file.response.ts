import { ApiProperty } from '@nestjs/swagger';

export class SetUserFileResponse {
  @ApiProperty()
  key: string;
}
