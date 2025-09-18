import { IsMongoId, IsNotEmpty } from 'class-validator';

export class CheckFeedbackGivenDto {
  @IsMongoId({ message: 'Matched User ID should be a valid Object ID' })
  @IsNotEmpty({ message: 'Matched User ID cannot be empty' })
  userId: string;
}
