import { UserNotificationInterval } from 'src/common/constants';

import { INotificationInterval } from '../interfaces/notification-interval.interface';

export const userNotificationIntervalsResponse: INotificationInterval[] = [
  {
    key: UserNotificationInterval.DoesntRepeat,
    name: "Doesn't repeat",
  },
  {
    key: UserNotificationInterval.RepeatDaily,
    name: 'Repeat daily',
  },
  {
    key: UserNotificationInterval.RepeatWeekly,
    name: 'Repeat weekly',
  },
  {
    key: UserNotificationInterval.RepeatBiWeekly,
    name: 'Repeat biweekly',
  },
  {
    key: UserNotificationInterval.RepeatMonthly,
    name: 'Repeat monthly',
  },
  {
    key: UserNotificationInterval.RepeatAnnually,
    name: 'Repeat annually',
  },
];
