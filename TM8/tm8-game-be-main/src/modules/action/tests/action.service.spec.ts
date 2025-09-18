/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';

import { AbstractActionRepository } from '../abstract/action.abstract.repository';
import { ActionService } from '../services/action.service';
import { findManyActionsResponse } from './mocks/delete-user-actions.mocks';
import { findManyInboundActionsResponse } from './mocks/delete-user-related-inbound-actions.mocks';
import { findManyOutboundActionsResponse } from './mocks/delete-user-related-outbound-actions.mocks';

describe('ActionService', () => {
  let actionService: ActionService;
  let actionRepository: jest.Mocked<AbstractActionRepository>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(ActionService).compile();

    actionService = unit;

    // @ts-ignore
    actionRepository = unitRef.get(AbstractActionRepository);
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('deleteUserRelatedInboundActions', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = findManyInboundActionsResponse[0].user.toString();
      actionRepository.findManyLean.mockResolvedValue(
        findManyInboundActionsResponse,
      );
      actionRepository.updateMany.mockResolvedValue(undefined);

      //act
      const result = await actionService.deleteUserRelatedInboundActions(
        userId,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('deleteUserRelatedOutboundActions', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = findManyOutboundActionsResponse[0].user.toString();
      actionRepository.findManyLean.mockResolvedValue(
        findManyOutboundActionsResponse,
      );
      actionRepository.updateMany.mockResolvedValue(undefined);

      //act
      const result = await actionService.deleteUserRelatedOutboundActions(
        userId,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('deleteUserActions', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = findManyActionsResponse[0].user.toString();
      actionRepository.findManyLean.mockResolvedValue(findManyActionsResponse);
      actionRepository.deleteMany.mockResolvedValue(undefined);

      //act
      const result = await actionService.deleteUserActions(userId);

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
