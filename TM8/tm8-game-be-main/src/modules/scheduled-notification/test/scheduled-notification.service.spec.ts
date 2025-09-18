/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';
import * as moment from 'moment';

import {
  TGMDConflictException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { NotificationSuccessResult } from 'src/modules/firebase/interface/notification-provider.interface';
import {
  INotificationProviderService,
  NotificationProviderServiceToken,
} from 'src/modules/notification-provider/interface/notification-provider.service.interface';
import { AbstractUserGameDataRepository } from 'src/modules/user-game-data/abstract/user-game-data.abstract.repository';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { AbstractScheduledNotificationRepository } from '../abstract/scheduled-notification.abstract.repositrory';
import { ScheduledNotificationDocument } from '../schemas/scheduled-notification.schema';
import { ScheduledNotificationService } from '../services/scheduled-notification.service';
import {
  createGroupNotificationInputMock,
  createGroupWithUserIdNotificationInputMock,
  createIndividualNoUserIdNotificationInputMock,
  createIndividualNotificationInputMock,
  createdGroupNotificationObject,
  createdIndividualNotificationObject,
  userIdArrayMock,
} from './mocks/create-notification.mocks';
import {
  notificationRepositoryResponseMock,
  userIds,
} from './mocks/delete-notification.mocks';
import {
  findOneNotificationResponseMock,
  findScheduledNotificationMock,
} from './mocks/find-scheduled-notification.mocks';
import {
  emptyListNotificationsResponseMock,
  listNotificationsInputMock,
  listNotificationsResponseMock,
  notificationPaginationParamsMock,
  notificationResponseMock,
} from './mocks/list-notifications.mocks';
import { sendGamePreferenceReminderNotificationMock } from './mocks/send-game-preference-reminder-notification.mocks';
import { inactiveUsersMock } from './mocks/send-inactive-user-reminder-notifications.mocks';
import {
  notificationRepositoryUpdateResponseMock,
  notificationUpdateResponseMock,
  updateGroupWithUserIdNotificationInputMock,
  updateIndividualNoUserIdNotificationInputMock,
  updateNotificationInputMock,
} from './mocks/update-notification.mocks';

describe('ScheduledNotificationService', () => {
  let notificationService: ScheduledNotificationService;
  let notificationRepository: jest.Mocked<AbstractScheduledNotificationRepository>;
  let notificationProvider: jest.Mocked<INotificationProviderService>;
  let userRepository: jest.Mocked<AbstractUserRepository>;
  let userGameDataRepository: jest.Mocked<AbstractUserGameDataRepository>;

  beforeAll(() => {
    const { unit, unitRef } = TestBed.create(
      ScheduledNotificationService,
    ).compile();

    notificationService = unit;

    notificationRepository = unitRef.get(
      // @ts-ignore
      AbstractScheduledNotificationRepository,
    );
    notificationProvider = unitRef.get(NotificationProviderServiceToken);
    userRepository = unitRef.get(
      // @ts-ignore
      AbstractUserRepository,
    );
    userGameDataRepository = unitRef.get(
      // @ts-ignore
      AbstractUserGameDataRepository,
    );

    jest.mock('moment', () => {
      return jest.fn(() => ({
        startOf: jest.fn(() => ({
          toDate: jest.fn(() => new Date(faker.date.recent())),
        })),
        endOf: jest.fn(() => ({
          toDate: jest.fn(() => new Date(faker.date.recent())),
        })),
      }));
    });
  });

  describe('listNotifications', () => {
    it('should return empty user list if no matched notifications found', async () => {
      //arrange
      notificationRepository.findManyLean.mockResolvedValue(null);
      notificationRepository.count.mockResolvedValue(0);

      //act
      expect(
        await notificationService.listNotifications(
          listNotificationsInputMock,
          notificationPaginationParamsMock,
        ),

        //assert
      ).toEqual(emptyListNotificationsResponseMock);
    });

    it('should return a list of notifications', async () => {
      //arrange
      notificationRepository.findManyLean.mockResolvedValue(
        notificationResponseMock,
      );
      notificationRepository.count.mockResolvedValue(1);

      //act
      const result = await notificationService.listNotifications(
        listNotificationsInputMock,
        notificationPaginationParamsMock,
      );

      //assert
      expect(result).toEqual(listNotificationsResponseMock);
    });
  });

  describe('createNotification', () => {
    it('should throw TGMDConflictException if group is individual and no individual user was provided', async () => {
      //arrange

      //act
      expect(
        async () =>
          await notificationService.createScheduledNotification(
            createIndividualNoUserIdNotificationInputMock,
          ),

        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDConflictException if group is not individual and individual user was provided', async () => {
      //arrange

      //act
      expect(
        async () =>
          await notificationService.createScheduledNotification(
            createGroupWithUserIdNotificationInputMock,
          ),

        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should return a created individual notification object', async () => {
      //arrange
      notificationRepository.createOne.mockResolvedValue(
        createdIndividualNotificationObject as ScheduledNotificationDocument,
      );

      //act
      const result = await notificationService.createScheduledNotification(
        createIndividualNotificationInputMock,
      );

      //assert
      expect(result).toEqual(createdIndividualNotificationObject);
    });

    it('should return a created group notification object', async () => {
      //arrange

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          ScheduledNotificationService.prototype as any,
          'getNotificationUsers',
        )
        .mockResolvedValue(userIdArrayMock);

      notificationRepository.createOne.mockResolvedValue(
        createdGroupNotificationObject as ScheduledNotificationDocument,
      );

      //act
      const result = await notificationService.createScheduledNotification(
        createGroupNotificationInputMock,
      );

      //assert
      expect(result).toEqual(createdGroupNotificationObject);
    });
  });

  describe('deleteNotification', () => {
    it('should throw TGMDNotFoundException if notification not found', async () => {
      //arrange

      notificationRepository.findManyLean.mockResolvedValue([]);

      //act
      expect(
        async () => {
          await notificationService.deleteScheduledNotifications(userIds);
        },

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return updated users response', async () => {
      //arrange

      notificationRepository.findManyLean.mockResolvedValue(
        notificationRepositoryResponseMock,
      );

      notificationRepository.deleteMany.mockResolvedValue(1);

      //act
      const result = await notificationService.deleteScheduledNotifications(
        userIds,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('updateNotification', () => {
    it('should throw TGMDNotFoundException if notification not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();

      notificationRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () => {
          await notificationService.updateScheduledNotification(
            userId,
            updateNotificationInputMock,
          );
        },

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDConflictException if group is individual and no individual user was provided', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      notificationRepository.findOneLean.mockResolvedValue(
        notificationRepositoryUpdateResponseMock,
      );

      //act
      expect(
        async () =>
          await notificationService.updateScheduledNotification(
            userId,
            updateIndividualNoUserIdNotificationInputMock,
          ),

        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDConflictException if group is not individual and individual user was provided', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      notificationRepository.findOneLean.mockResolvedValue(
        notificationRepositoryUpdateResponseMock,
      );

      //act
      expect(
        async () =>
          await notificationService.updateScheduledNotification(
            userId,
            updateGroupWithUserIdNotificationInputMock,
          ),

        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should return updated notification response', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();

      notificationRepository.findOneLean.mockResolvedValue(
        notificationRepositoryUpdateResponseMock,
      );

      notificationRepository.updateOneById.mockResolvedValue(
        notificationUpdateResponseMock,
      );

      //act
      const result = await notificationService.updateScheduledNotification(
        userId,
        updateNotificationInputMock,
      );

      //assert
      expect(result).toEqual(notificationUpdateResponseMock);
    });
  });

  describe('findScheduledNotification', () => {
    it('should throw TGMDNotFoundException if scheduled notification is not found', async () => {
      //arrange
      notificationRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () =>
          await notificationService.findScheduledNotification(
            findScheduledNotificationMock,
          ),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return scheduled notification response', async () => {
      //arrange
      notificationRepository.findOneLean.mockResolvedValue(
        findOneNotificationResponseMock,
      );

      //act
      const result = await notificationService.findScheduledNotification(
        findScheduledNotificationMock,
      );

      //assert
      expect(result).toEqual(findOneNotificationResponseMock);
    });
  });

  describe('prepareScheduledNotifications', () => {
    it('should return undefined on success', async () => {
      //arrange
      jest
        .spyOn(moment().startOf('minute'), 'toDate')
        .mockReturnValue(new Date());
      jest
        .spyOn(moment().endOf('minute'), 'toDate')
        .mockReturnValue(new Date());

      notificationRepository.getScheduledNotificationsWithUsers.mockResolvedValue(
        [findOneNotificationResponseMock],
      );

      notificationProvider.sendMultipleNotifications.mockResolvedValue({
        status: NotificationSuccessResult.SUCCESS,
        sentCount: 1,
      });

      notificationRepository.updateOneById.mockResolvedValue(undefined);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          ScheduledNotificationService.prototype as any,
          'createUserNotifications',
        )
        .mockResolvedValue(undefined);

      //act
      const result = await notificationService.prepareScheduledNotifications();

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('sendInactiveUserReminderNotifications', () => {
    it('should return undefined on success', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(inactiveUsersMock);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          ScheduledNotificationService.prototype as any,
          'setNotificationsPayloadAndSend',
        )
        .mockResolvedValue(undefined);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          ScheduledNotificationService.prototype as any,
          'createUserNotifications',
        )
        .mockResolvedValue(undefined);

      //act
      const result =
        await notificationService.sendInactiveUserReminderNotifications();

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('sendOnboardingReminderNotifications', () => {
    it('should return undefined on success', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(inactiveUsersMock);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          ScheduledNotificationService.prototype as any,
          'setNotificationsPayloadAndSend',
        )
        .mockResolvedValue(undefined);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          ScheduledNotificationService.prototype as any,
          'createUserNotifications',
        )
        .mockResolvedValue(undefined);

      //act
      const result =
        await notificationService.sendInactiveUserReminderNotifications();

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('sendGamePreferenceReminderNotifications', () => {
    it('should return undefined on success', async () => {
      //arrange
      userGameDataRepository.findManyLean.mockResolvedValue(
        sendGamePreferenceReminderNotificationMock,
      );

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          ScheduledNotificationService.prototype as any,
          'setNotificationsPayloadAndSend',
        )
        .mockResolvedValue(undefined);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          ScheduledNotificationService.prototype as any,
          'createUserNotifications',
        )
        .mockResolvedValue(undefined);

      //act
      const result =
        await notificationService.sendInactiveUserReminderNotifications();

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
