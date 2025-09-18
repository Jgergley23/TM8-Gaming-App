import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class UserProfileResponse {
  @ApiProperty()
  username: string;

  @ApiPropertyOptional()
  description?: string;

  @ApiPropertyOptional()
  photo?: string;

  @ApiPropertyOptional()
  audio?: string;

  @ApiProperty()
  friendsCount: number;

  @ApiPropertyOptional()
  isFriend?: boolean;

  @ApiPropertyOptional()
  sentFriendRequest?: boolean;

  @ApiPropertyOptional()
  receivedFriendRequest?: boolean;
}
