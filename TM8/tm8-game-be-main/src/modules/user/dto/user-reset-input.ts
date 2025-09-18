import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId } from 'class-validator';

export class UserResetInput {
  @ApiProperty()
  @IsMongoId({ each: true, message: 'Please provide a valid user id' })
  userIds: string[];
}
