import { ApiProperty } from '@nestjs/swagger';

export class AcceptPotentialMatchResponse {
  @ApiProperty()
  isMatch: boolean;
}
