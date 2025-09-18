import { WarningReason } from 'src/common/constants';

import { IUserWarningType } from '../interfaces/user-warning-type.interface';

export const userWarningTypeResponse: IUserWarningType[] = [
  {
    key: WarningReason.ImpersonationOrFalseIdentity,
    name: 'Impersonation or False Identity',
  },
  {
    key: WarningReason.CheatingOrExploiting,
    name: 'Cheating or Exploiting',
  },
  {
    key: WarningReason.InactivityOrAbandonment,
    name: 'Inactivity or Abandonment',
  },
  {
    key: WarningReason.InappropriateBehavior,
    name: 'Inappropriate Behavior',
  },
  {
    key: WarningReason.RepeatedDisruptions,
    name: 'Repeated Disruptions',
  },
  {
    key: WarningReason.ViolatingCommunityGuidelines,
    name: 'Violating Community Guidelines',
  },
];
