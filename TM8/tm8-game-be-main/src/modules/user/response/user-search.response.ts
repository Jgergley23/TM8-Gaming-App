import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class UserSearchResponse {
  @ApiProperty()
  id: string;

  @ApiProperty()
  username: string;

  @ApiProperty()
  friend: boolean;

  @ApiPropertyOptional()
  photoKey?: string;
}
