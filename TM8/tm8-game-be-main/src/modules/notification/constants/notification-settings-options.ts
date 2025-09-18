import { INotificationSettingsOption } from '../interfaces/notification-settings-option.interface';

export const notificationSettingsOptions: INotificationSettingsOption[] = [
  {
    keyValue: 'enabled',
    displayValue: 'Enable notifications',
  },
  {
    keyValue: 'match',
    displayValue: 'New match made',
  },
  {
    keyValue: 'message',
    displayValue: 'New message',
  },
  {
    keyValue: 'friendAdded',
    displayValue: 'Added as friend',
  },
  {
    keyValue: 'news',
    displayValue: 'News',
  },
  {
    keyValue: 'reminders',
    displayValue: 'Reminders',
  },
];
