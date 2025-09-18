import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId, IsNotEmpty, IsString } from 'class-validator';

export class CreateMessageNotificationDto {
  @ApiProperty()
  @IsString({ message: 'Sender username must be a string' })
  @IsNotEmpty({ message: 'Sender username is required' })
  senderUsername: string;

  @ApiProperty()
  @IsString({ message: 'Description must be a string' })
  @IsNotEmpty({ message: 'Description is required' })
  message: string;

  @ApiProperty()
  @IsMongoId({ message: 'Recipient ID must be an ObjectID' })
  @IsNotEmpty({ message: 'Recipient ID is required' })
  recipientId: string;

  @ApiProperty()
  @IsString({ message: 'Redirect screen must be a string' })
  @IsNotEmpty({ message: 'Redirect screen is required' })
  redirectScreen: string;
}
