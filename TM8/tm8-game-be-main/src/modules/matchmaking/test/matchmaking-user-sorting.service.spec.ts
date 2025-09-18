/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';

import { AbstractOnlinePresenceService } from 'src/modules/online-presence/abstract';
import {
    offlineUserId,
    onlineUserId,
} from 'src/modules/online-presence/tests/mocks/check-online-users.mock';

import { MatchmakingUserSortingService } from '../services/matchmaking-user-sorting.service';

describe('MatchmakingUserSortingService', () => {
  let matchmakingUserSortingService: MatchmakingUserSortingService;
  let onlinePresenceService: jest.Mocked<AbstractOnlinePresenceService>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(
      MatchmakingUserSortingService,
    ).compile();

    matchmakingUserSortingService = unit;

    // @ts-ignore
    onlinePresenceService = unitRef.get(AbstractOnlinePresenceService);
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('sortMatchmakingResultsByOnlineStatus', () => {
    it('should return an empty list', async () => {
      // arrange
      onlinePresenceService.filterOnlineUsers.mockResolvedValue([]);

      // act
      const sortedUserIds =
        await matchmakingUserSortingService.sortMatchmakingResultsByOnlineStatus(
          [],
        );

      // assert
      expect(sortedUserIds).toHaveLength(0);
      expect(sortedUserIds).toMatchObject([]);
    });

    it('should return unmodified list of user IDs', async () => {
      // arrange
      const userIds = [onlineUserId, offlineUserId];
      onlinePresenceService.filterOnlineUsers.mockResolvedValue([onlineUserId]);

      // act
      const sortedUserIds =
        await matchmakingUserSortingService.sortMatchmakingResultsByOnlineStatus(
          userIds,
        );

      // assert
      expect(sortedUserIds).toHaveLength(userIds.length);
      expect(sortedUserIds).toMatchObject(userIds);
    });

    it('should return modified list of user IDs', async () => {
      // arrange
      const userIds = [offlineUserId, onlineUserId];
      onlinePresenceService.filterOnlineUsers.mockResolvedValue([onlineUserId]);

      // act
      const sortedUserIds =
        await matchmakingUserSortingService.sortMatchmakingResultsByOnlineStatus(
          userIds,
        );

      // assert
      expect(sortedUserIds).toHaveLength(userIds.length);
      expect(sortedUserIds).toMatchObject(userIds.reverse());
    });
  });
});
