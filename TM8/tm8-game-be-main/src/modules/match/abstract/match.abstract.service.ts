import { CheckFeedbackGivenResponse } from '../response/check-feedback-given.response';
import { CheckMatchExistsResponse } from '../response/check-match-exists.response';

export abstract class AbstractMatchService {
  abstract giveMatchUserFeedback(
    currentUserId: string,
    matchedUserId: string,
    rating: number,
  ): Promise<void>;
  abstract checkIfMatchFeedbackGiven(
    currentUserId: string,
    matchedUserId: string,
  ): Promise<CheckFeedbackGivenResponse>;
  abstract deleteUserMatches(userId: string): Promise<void>;
  abstract checkForExistingMatch(
    currentUserId: string,
    checkUserId: string,
  ): Promise<CheckMatchExistsResponse>;
}
