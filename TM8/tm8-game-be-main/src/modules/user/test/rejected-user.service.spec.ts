/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';

import { AbstractUserRepository } from '../abstract/user.abstract.repository';
import { RejectedUserService } from '../services/rejected-user.service';

describe('RejectedUserService', () => {
  let rejectedUserService: RejectedUserService;
  let userRepository: jest.Mocked<AbstractUserRepository>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(RejectedUserService).compile();

    rejectedUserService = unit;

    // @ts-ignore
    userRepository = unitRef.get(AbstractUserRepository);
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('cleanupRejectedUsers', () => {
    it('should clean up old rejected users from the database', async () => {
      //arrange
      userRepository.updateMany.mockResolvedValue(undefined);

      //act
      const result = await rejectedUserService.cleanupRejectedUsers();

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
