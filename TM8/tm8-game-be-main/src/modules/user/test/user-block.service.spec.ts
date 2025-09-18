/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';

import { TGMDNotFoundException } from 'src/common/exceptions/custom.exception';
import { AbstractActionRepository } from 'src/modules/action/abstract/action.abstract.repository';
import { AbstractFriendsRepository } from 'src/modules/friends/abstract/friends.abstract.repository';

import { AbstractUserRepository } from '../abstract/user.abstract.repository';
import { UserBlockService } from '../services/user-block.service';
import {
  blockUserFriendsRepositoryResponse,
  blockUserUserRepositoryResponse,
} from './mocks/block-user.mocks';
import {
  blockedUsersListResponseMock,
  blockedUsersRepositoryResponseMock,
  blockedUsersResponseMock,
  emptyListBlocksResponseMock,
  listBlocksParamsMock,
} from './mocks/list-blocked-users.mocks';
import { unblockUserUserRepositoryResponse } from './mocks/unblock-user.mocks';

describe('UserService', () => {
  let userBlockService: UserBlockService;
  let userRepository: jest.Mocked<AbstractUserRepository>;
  let actionRepository: jest.Mocked<AbstractActionRepository>;
  let friendsRepository: jest.Mocked<AbstractFriendsRepository>;
  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(UserBlockService).compile();

    userBlockService = unit;

    // @ts-ignore
    userRepository = unitRef.get(AbstractUserRepository);

    // @ts-ignore
    actionRepository = unitRef.get(AbstractActionRepository);

    // @ts-ignore
    friendsRepository = unitRef.get(AbstractFriendsRepository);
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('listUserBlocks', () => {
    it('should return empty user list if no blocked users found', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      actionRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        await userBlockService.listBlockedUsers(userId, listBlocksParamsMock),

        //assert
      ).toEqual(emptyListBlocksResponseMock);
    });

    it('should return a list of blocked users', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      actionRepository.findOneLean.mockResolvedValue(
        blockedUsersRepositoryResponseMock,
      );
      userRepository.findManyLean.mockResolvedValue(blockedUsersResponseMock);
      userRepository.count.mockResolvedValue(1);

      //act
      const result = await userBlockService.listBlockedUsers(
        userId,
        listBlocksParamsMock,
      );

      //assert
      expect(result).toEqual(blockedUsersListResponseMock);
    });
  });

  describe('blockUser', () => {
    it('should throw TGMDNotFoundException if block target user is not found', async () => {
      //arrange
      const blockerId = faker.database.mongodbObjectId();
      const blockTargetId = faker.database.mongodbObjectId();
      userRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () => await userBlockService.blockUser(blockerId, blockTargetId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined on success', async () => {
      //arrange
      const blockerId = faker.database.mongodbObjectId();
      const blockTargetId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue(
        blockUserUserRepositoryResponse,
      );
      friendsRepository.findOneLean.mockResolvedValue(
        blockUserFriendsRepositoryResponse,
      );
      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserBlockService.prototype as any, 'addBlockToBlockRequester')
        .mockResolvedValue(undefined);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserBlockService.prototype as any, 'addBlockToBlockTargetUser')
        .mockResolvedValue(undefined);

      //act
      const result = await userBlockService.blockUser(blockerId, blockTargetId);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('unblockUser', () => {
    it('should throw TGMDNotFoundException if unblock target user is not found', async () => {
      //arrange
      const blockerId = faker.database.mongodbObjectId();
      const blockTargetIds = [faker.database.mongodbObjectId()];
      userRepository.findManyLean.mockResolvedValue([]);

      //act
      expect(
        async () =>
          await userBlockService.unblockUsers(blockerId, blockTargetIds),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if block is not found in blocker blocks', async () => {
      //arrange
      const blockerId = faker.database.mongodbObjectId();
      const blockTargetIds = [faker.database.mongodbObjectId()];
      userRepository.findManyLean.mockResolvedValue(
        unblockUserUserRepositoryResponse,
      );

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          UserBlockService.prototype as any,
          'removeBlocksFromBlockRequester',
        )
        .mockRejectedValue(new TGMDNotFoundException(''));

      //act
      expect(
        async () =>
          await userBlockService.unblockUsers(blockerId, blockTargetIds),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if block is not found in blocked user blocks', async () => {
      //arrange
      const blockerId = faker.database.mongodbObjectId();
      const blockTargetIds = [faker.database.mongodbObjectId()];
      userRepository.findManyLean.mockResolvedValue(
        unblockUserUserRepositoryResponse,
      );

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          UserBlockService.prototype as any,
          'removeBlocksFromBlockRequester',
        )
        .mockResolvedValue(undefined);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserBlockService.prototype as any, 'removeBlockFromTargetUsers')
        .mockRejectedValue(new TGMDNotFoundException(''));

      //act
      expect(
        async () =>
          await userBlockService.unblockUsers(blockerId, blockTargetIds),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if block is not found in blocked user blocks', async () => {
      //arrange
      const blockerId = faker.database.mongodbObjectId();
      const blockTargetIds = [faker.database.mongodbObjectId()];
      userRepository.findManyLean.mockResolvedValue(
        unblockUserUserRepositoryResponse,
      );

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          UserBlockService.prototype as any,
          'removeBlocksFromBlockRequester',
        )
        .mockResolvedValue(undefined);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserBlockService.prototype as any, 'removeBlockFromTargetUsers')
        .mockResolvedValue(undefined);

      //act
      const result = await userBlockService.unblockUsers(
        blockerId,
        blockTargetIds,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
