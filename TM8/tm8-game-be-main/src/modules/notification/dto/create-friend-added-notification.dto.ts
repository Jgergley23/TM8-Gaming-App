import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId, IsNotEmpty, IsString } from 'class-validator';

export class CreateFriendAddedNotificationDto {
  @ApiProperty()
  @IsString({ message: 'Friend username must be a string' })
  @IsNotEmpty({ message: 'Friend username is required' })
  friendUsername: string;

  @ApiProperty()
  @IsMongoId({ message: 'Recipient ID must be an ObjectID' })
  @IsNotEmpty({ message: 'Recipient ID is required' })
  recipientId: string;

  @ApiProperty()
  @IsString({ message: 'Redirect screen must be a string' })
  @IsNotEmpty({ message: 'Redirect screen is required' })
  redirectScreen: string;
}
