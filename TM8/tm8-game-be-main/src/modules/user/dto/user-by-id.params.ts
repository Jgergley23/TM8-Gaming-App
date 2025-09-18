import { ApiProperty } from '@nestjs/swagger';
import { IsMongoId } from 'class-validator';

export class GetUserByIdParams {
  @ApiProperty({
    name: 'userId',
    description: 'User ID',
    type: String,
  })
  @IsMongoId({ message: 'User ID should be a valid Object ID' })
  userId: string;
}
