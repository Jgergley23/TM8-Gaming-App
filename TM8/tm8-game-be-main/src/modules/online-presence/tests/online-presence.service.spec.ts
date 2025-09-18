/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';

import { AbstractCacheService } from 'src/modules/redis/abstract';

import { OnlinePresenceService } from '../services';
import {
  offlineUserId,
  onlineUserId,
  onlineUsersSetMock,
} from './mocks/check-online-users.mock';

describe('OnlinePresenceService', () => {
  let onlinePresenceService: OnlinePresenceService;
  let cacheService: jest.Mocked<AbstractCacheService>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(OnlinePresenceService).compile();

    onlinePresenceService = unit;

    // @ts-ignore
    cacheService = unitRef.get(AbstractCacheService);
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('getOnlineUsers', () => {
    it('should return a single user ID', async () => {
      // arrange
      cacheService.readSet.mockResolvedValue(onlineUsersSetMock);

      // act
      const onlineUserIds = await onlinePresenceService.filterOnlineUsers([
        onlineUserId,
        offlineUserId,
      ]);

      // assert
      expect(onlineUserIds).toHaveLength(1);
      expect(onlineUserIds).toMatchObject([onlineUserId]);
    });

    it('should return an empty array', async () => {
      // arrange
      cacheService.readSet.mockResolvedValue(onlineUsersSetMock);

      // act
      const onlineUserIds = await onlinePresenceService.filterOnlineUsers([
        offlineUserId,
      ]);

      // assert
      expect(onlineUserIds).toHaveLength(0);
      expect(onlineUserIds).toMatchObject([]);
    });
  });
});
