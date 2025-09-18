import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId } from 'class-validator';

export class GetUsersByIdsParams {
  @ApiProperty({
    name: 'userIds',
    description: 'User IDs',
    type: [String],
  })
  @IsMongoId({ each: true, message: 'User ID should be a valid Object ID' })
  userIds: string[];
}
