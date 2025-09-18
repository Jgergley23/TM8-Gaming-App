import { ReportReason } from 'src/common/constants';

import { IUserReportType } from '../interfaces/user-report-type.interface';

export const userReportTypeResponse: IUserReportType[] = [
  {
    key: ReportReason.HarrasmentAndBullying,
    name: 'Harrassment and Bullying',
  },
  {
    key: ReportReason.InappropriateContent,
    name: 'Inappropriate Content',
  },
  {
    key: ReportReason.SpamAndScams,
    name: 'Spam and Scams',
  },
  {
    key: ReportReason.ViolenceOrThreats,
    name: 'Violence or Threats',
  },
  {
    key: ReportReason.HateSpeechOrDiscrimination,
    name: 'Hate Speech or Discrimination',
  },
  {
    key: ReportReason.PrivacyViolations,
    name: 'Privacy Violations',
  },
  {
    key: ReportReason.ViolationOfPlatformPolicies,
    name: 'Violation of Platform Policies',
  },
  {
    key: ReportReason.SafetyConcerns,
    name: 'Safety Concerns',
  },
];
