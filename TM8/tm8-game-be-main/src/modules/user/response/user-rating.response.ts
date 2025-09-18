import { ApiProperty } from '@nestjs/swagger';

export class UserRatingResponse {
  @ApiProperty({ type: Number })
  average: number;

  @ApiProperty({ type: [Number] })
  ratings: number[];
}
