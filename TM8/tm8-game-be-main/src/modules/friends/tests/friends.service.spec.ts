/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';

import { AbstractFriendsRepository } from '../abstract/friends.abstract.repository';
import { FriendsService } from '../services/friends.service';
import {
  findFriendFriendsRepositoryMock,
  findFriendsRepositoryMock,
} from './mocks/delete-account-friends.mocks';

describe('FriendsService', () => {
  let friendsService: FriendsService;
  let friendsRepository: jest.Mocked<AbstractFriendsRepository>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(FriendsService).compile();

    friendsService = unit;

    // @ts-ignore
    friendsRepository = unitRef.get(AbstractFriendsRepository);
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('deleteAccountFriends', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = findFriendsRepositoryMock.user.toString();

      friendsRepository.findOneLean.mockResolvedValue(
        findFriendsRepositoryMock,
      );

      friendsRepository.deleteMany.mockResolvedValue(undefined);

      friendsRepository.findManyLean.mockResolvedValue(
        findFriendFriendsRepositoryMock,
      );

      friendsRepository.updateMany.mockResolvedValue(undefined);
      //act
      const result = await friendsService.deleteAccountFriends(userId);

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
