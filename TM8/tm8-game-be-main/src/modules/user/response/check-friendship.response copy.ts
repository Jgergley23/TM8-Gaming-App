import { ApiProperty } from '@nestjs/swagger';

export class CheckBlockStatusResponse {
  @ApiProperty()
  isBlocked: boolean;
}
