import { Type } from 'class-transformer';
import { IsMongoId, IsNotEmpty, IsNumber, Max, Min } from 'class-validator';

export class GiveMatchFeedbackDto {
  /*  @ApiProperty({
    name: 'matchId',
    description: 'Match ID',
    type: String,
  }) */
  @IsMongoId({ message: 'Match ID should be a valid Object ID' })
  @IsNotEmpty({ message: 'Match ID cannot be empty' })
  matchId: string;

  /*  @ApiProperty({
    name: 'rating',
    description: 'Match Feedback Rating',
    type: Number,
  }) */
  @Type(() => Number)
  @IsNumber({}, { message: 'Please provide a number' })
  @Min(1, { message: 'Rating cannot be less than 1' })
  @Max(5, { message: 'Rating cannot be more than 5' })
  @IsNotEmpty({ message: 'Rating cannot be empty' })
  rating: number;
}
