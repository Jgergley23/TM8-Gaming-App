import { UserNotificationType } from 'src/common/constants';

import { INotificationType } from '../interfaces/notification-type.interface';

export const userNotificationTypesResponse: INotificationType[] = [
  {
    key: UserNotificationType.CommunityNews,
    name: 'Community news',
  },
  {
    key: UserNotificationType.ExclusiveOffers,
    name: 'Exclusive offers',
  },
  {
    key: UserNotificationType.GameUpdate,
    name: 'Game update',
  },
  {
    key: UserNotificationType.NewFeatures,
    name: 'New features',
  },
  {
    key: UserNotificationType.Other,
    name: 'Other',
  },
  {
    key: UserNotificationType.SystemMaintenance,
    name: 'System maintenance',
  },
];
