/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';
import * as moment from 'moment';

import { UserNotificationType } from 'src/common/constants';
import {
  TGMDExternalServiceException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import {
  INotificationProviderService,
  NotificationProviderServiceToken,
} from 'src/modules/notification-provider/interface/notification-provider.service.interface';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';
import { User } from 'src/modules/user/schemas/user.schema';

import { AbstractNotificationRepository } from '../abstract/notification.abstract.repository';
import { UpdateNotificationSettingsDto } from '../dto/update-notification-settings.dto';
import { UnreadNotificationsResponse } from '../response/unread-notifications.response';
import { Notification } from '../schemas/notification.schema';
import { NotificationService } from '../services/notification.service';
import { oldNotificationRepositoryMock } from './mocks/clean-up-old-notifications.mocks';
import { createCallNotificationInput } from './mocks/create-call-notification.mocks';
import { createFriendAddedNotificationInput } from './mocks/create-friend-added-notification.mocks';
import { createMatchNotificationInput } from './mocks/create-match-notification.mocks';
import { createMessageNotificationInput } from './mocks/create-message-notification.mocks';
import { deleteUserNotificationsMock } from './mocks/delete-user-notifications.mocks';
import {
  emptyListUserNotificationsResponseMock,
  listUserNotificationsPaginationParams,
  listUserNotificationsResponseMock,
  userNotificationsResponseMock,
} from './mocks/list-user-notifications.mocks';
import { markNotificationAsReadResponseMock } from './mocks/mark-notification-as-read.mocks';
import { userNotificationDetailResponseMock } from './mocks/notification-detail.mocks';

describe('NotificationService', () => {
  let notificationService: NotificationService;
  let userRepository: jest.Mocked<AbstractUserRepository>;
  let notificationRepository: jest.Mocked<AbstractNotificationRepository>;
  let notificationProvider: jest.Mocked<INotificationProviderService>;

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

  beforeEach(() => {
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { unit, unitRef } = TestBed.create(NotificationService).compile();

    notificationService = unit;

    // @ts-ignore
    userRepository = unitRef.get(AbstractUserRepository);
    // @ts-ignore
    notificationRepository = unitRef.get(AbstractNotificationRepository);
    notificationProvider = unitRef.get(NotificationProviderServiceToken);
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('refreshToken', () => {
    it('should return a list of users', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const notificationToken = faker.internet.password();

      userRepository.updateOneById.mockResolvedValue(undefined);

      //act
      const result = await notificationService.refreshToken(
        userId,
        notificationToken,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('createMessageNotification', () => {
    it('should throw TGMDNotFoundException if recepient is not found', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(undefined);

      //act
      expect(async () => {
        await notificationService.createMessageNotification(
          createMessageNotificationInput,
        );
        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDExternalServiceException if notification sending fails', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue({
        _id: createMessageNotificationInput.recipientId,
      } as User);

      jest
        .spyOn(moment().startOf('month'), 'toDate')
        .mockReturnValue(new Date());
      jest.spyOn(moment().endOf('month'), 'toDate').mockReturnValue(new Date());

      notificationRepository.createOne.mockResolvedValue(undefined);

      notificationProvider.sendOneNotification.mockRejectedValue(
        new TGMDExternalServiceException(''),
      );

      //act
      expect(async () => {
        await notificationService.createMessageNotification(
          createMessageNotificationInput,
        );
        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should throw TGMDExternalServiceException if notification sending fails', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue({
        _id: createMessageNotificationInput.recipientId,
      } as User);

      jest
        .spyOn(moment().startOf('month'), 'toDate')
        .mockReturnValue(new Date());
      jest.spyOn(moment().endOf('month'), 'toDate').mockReturnValue(new Date());

      notificationRepository.createOne.mockResolvedValue(undefined);

      notificationProvider.sendOneNotification.mockResolvedValue(undefined);

      //act
      const result = await notificationService.createMessageNotification(
        createMessageNotificationInput,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('createFriendAddedNotification', () => {
    it('should throw TGMDNotFoundException if recepient is not found', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(undefined);

      //act
      expect(async () => {
        await notificationService.createFriendAddedNotification(
          createFriendAddedNotificationInput,
        );
        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDExternalServiceException if notification sending fails', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue({
        _id: createFriendAddedNotificationInput.recipientId,
      } as User);

      jest
        .spyOn(moment().startOf('month'), 'toDate')
        .mockReturnValue(new Date());
      jest.spyOn(moment().endOf('month'), 'toDate').mockReturnValue(new Date());

      notificationRepository.createOne.mockResolvedValue(undefined);

      notificationProvider.sendOneNotification.mockRejectedValue(
        new TGMDExternalServiceException(''),
      );

      //act
      expect(async () => {
        await notificationService.createFriendAddedNotification(
          createFriendAddedNotificationInput,
        );
        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return undefined on success', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue({
        _id: createFriendAddedNotificationInput.recipientId,
      } as User);

      jest
        .spyOn(moment().startOf('month'), 'toDate')
        .mockReturnValue(new Date());
      jest.spyOn(moment().endOf('month'), 'toDate').mockReturnValue(new Date());

      notificationRepository.createOne.mockResolvedValue(undefined);

      notificationProvider.sendOneNotification.mockResolvedValue(undefined);

      //act
      const result = await notificationService.createFriendAddedNotification(
        createFriendAddedNotificationInput,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('createCallNotification', () => {
    it('should throw TGMDNotFoundException if recepient is not found', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(undefined);

      //act
      expect(async () => {
        await notificationService.createCallNotification(
          createCallNotificationInput,
        );
        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDExternalServiceException if notification sending fails', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue({
        _id: createCallNotificationInput.recipientId,
      } as User);

      jest
        .spyOn(moment().startOf('month'), 'toDate')
        .mockReturnValue(new Date());
      jest.spyOn(moment().endOf('month'), 'toDate').mockReturnValue(new Date());

      notificationRepository.createOne.mockResolvedValue(undefined);

      notificationProvider.sendOneNotification.mockRejectedValue(
        new TGMDExternalServiceException(''),
      );

      //act
      expect(async () => {
        await notificationService.createCallNotification(
          createCallNotificationInput,
        );
        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return undefined on success', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue({
        _id: createCallNotificationInput.recipientId,
      } as User);

      jest
        .spyOn(moment().startOf('month'), 'toDate')
        .mockReturnValue(new Date());
      jest.spyOn(moment().endOf('month'), 'toDate').mockReturnValue(new Date());

      notificationRepository.createOne.mockResolvedValue(undefined);

      notificationProvider.sendOneNotification.mockResolvedValue(undefined);

      //act
      const result = await notificationService.createCallNotification(
        createCallNotificationInput,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('createMatchNotification', () => {
    it('should return undefined on success', async () => {
      //arrange
      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(NotificationService.prototype as any, 'createNotification')
        .mockResolvedValue(undefined);

      //act
      const result = await notificationService.createMatchNotification(
        createMatchNotificationInput,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('listUserNotifications', () => {
    it('should return empty notification list if no notifications found', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      notificationRepository.findManyLean.mockResolvedValue([]);

      notificationRepository.count.mockResolvedValue(0);

      //act
      expect(
        await notificationService.listUserNotifications(
          userId,
          listUserNotificationsPaginationParams,
        ),

        //assert
      ).toEqual(emptyListUserNotificationsResponseMock);
    });

    it('should return a list of users', async () => {
      const userId = faker.database.mongodbObjectId();

      notificationRepository.findManyLean.mockResolvedValue(
        userNotificationsResponseMock,
      );

      notificationRepository.count.mockResolvedValue(1);

      //act
      const result = await notificationService.listUserNotifications(
        userId,
        listUserNotificationsPaginationParams,
      );

      //assert
      expect(result).toEqual(listUserNotificationsResponseMock);
    });
  });

  describe('deleteNotification', () => {
    it('should throw TGMDNotFoundException if user notification not found', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const notificationId = faker.database.mongodbObjectId();

      notificationRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () =>
          await notificationService.deleteNotification(userId, notificationId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined on success', async () => {
      const userId = faker.database.mongodbObjectId();
      const notificationId = faker.database.mongodbObjectId();

      notificationRepository.findOneLean.mockResolvedValue({
        _id: notificationId,
        user: userId,
      } as Notification);

      //act
      const result = await notificationService.deleteNotification(
        userId,
        notificationId,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('getNotificationDetail', () => {
    it('should throw TGMDNotFoundException if user notification not found', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const notificationId = faker.database.mongodbObjectId();

      notificationRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () =>
          await notificationService.getNotificationDetail(
            userId,
            notificationId,
          ),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return notification detail on success', async () => {
      const userId = userNotificationDetailResponseMock.user as string;
      const notificationId = userNotificationDetailResponseMock._id;

      notificationRepository.findOneLean.mockResolvedValue(
        userNotificationDetailResponseMock,
      );

      //act
      const result = await notificationService.getNotificationDetail(
        userId,
        notificationId,
      );

      //assert
      expect(result).toEqual(userNotificationDetailResponseMock);
    });
  });

  describe('markNotificationAsRead', () => {
    it('should throw TGMDNotFoundException if user notification not found', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const notificationId = faker.database.mongodbObjectId();

      notificationRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () =>
          await notificationService.markNotificationAsRead(
            userId,
            notificationId,
          ),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined on success', async () => {
      const userId = markNotificationAsReadResponseMock.user as string;
      const notificationId = markNotificationAsReadResponseMock._id;

      notificationRepository.findOneLean.mockResolvedValue(
        markNotificationAsReadResponseMock,
      );

      notificationRepository.updateOneById.mockResolvedValue(undefined);

      //act
      const result = await notificationService.markNotificationAsRead(
        userId,
        notificationId,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('checkUnreadNotifications', () => {
    it('should return unread notifications response on success', async () => {
      const userId = markNotificationAsReadResponseMock.user as string;
      const response: UnreadNotificationsResponse = { count: 5, unread: true };

      notificationRepository.count.mockResolvedValue(5);

      //act
      const result = await notificationService.checkUnreadNotifications(userId);

      //assert
      expect(result).toEqual(response);
    });
  });

  describe('checkUnreadNotifications', () => {
    it('should return unread notifications response on success', async () => {
      const userId = markNotificationAsReadResponseMock.user as string;
      const updateNotificationSettingsInput: UpdateNotificationSettingsDto = {
        enabled: true,
      };

      userRepository.updateOneById.mockResolvedValue(undefined);

      //act
      const result = await notificationService.updateNotificationSettings(
        userId,
        updateNotificationSettingsInput,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('cleanUpOldNotifications', () => {
    it('should return unread notifications response on success', async () => {
      //arrange
      notificationRepository.findManyLean.mockResolvedValue(
        oldNotificationRepositoryMock,
      );

      notificationRepository.deleteMany.mockResolvedValue(undefined);

      //act
      const result = await notificationService.cleanUpOldNotifications();

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('deleteUserNotifications', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = deleteUserNotificationsMock[0].user as string;

      notificationRepository.findManyLean.mockResolvedValue(
        deleteUserNotificationsMock,
      );

      notificationRepository.deleteMany.mockResolvedValue(undefined);

      //act
      const result = await notificationService.deleteUserNotifications(userId);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('removeUserNotificationsOfSpecifiedType', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = deleteUserNotificationsMock[0].user as string;

      notificationRepository.findManyLean.mockResolvedValue(
        deleteUserNotificationsMock,
      );
      notificationRepository.deleteMany.mockResolvedValue(undefined);

      //act
      const result =
        await notificationService.removeUserNotificationsOfSpecifiedType(
          [userId],
          [UserNotificationType.Ban],
        );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('createAndSendBanNotifications', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userIds = [faker.database.mongodbObjectId()];
      const note = faker.lorem.sentence();

      userRepository.findManyLean.mockResolvedValue([]);

      //act
      const result = await notificationService.createAndSendBanNotifications(
        userIds,
        note,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('createAndSendSuspendNotifications', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userIds = [faker.database.mongodbObjectId()];
      const note = faker.lorem.sentence();
      const suspensionEndDate = faker.date.future();

      userRepository.findManyLean.mockResolvedValue([]);

      //act
      const result =
        await notificationService.createAndSendSuspendNotifications(
          userIds,
          note,
          suspensionEndDate,
        );

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
