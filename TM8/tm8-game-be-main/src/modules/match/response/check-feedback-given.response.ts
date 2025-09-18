import { ApiProperty } from '@nestjs/swagger';

export class CheckFeedbackGivenResponse {
  @ApiProperty()
  feedbackGiven: boolean;
}
