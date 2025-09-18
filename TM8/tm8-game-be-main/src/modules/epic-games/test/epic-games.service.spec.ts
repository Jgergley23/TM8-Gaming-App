/* eslint-disable @typescript-eslint/ban-ts-comment */
import 'reflect-metadata';

import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';
import axios from 'axios';

import {
  TGMDConflictException,
  TGMDExternalServiceException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';
import { User } from 'src/modules/user/schemas/user.schema';

import { EpicGamesService } from '../services/epic-games.service';
import {
  epicGamesUserResponseMock,
  getEpicGamesUserInputMock,
} from './mocks/get-epic-games-user.mocks';
import {
  epicGamesTokenResponseMock,
  sendEpicTokenRequestInputMock,
} from './mocks/send-epic-token-request.mocks';
import {
  storeEpicDataUserResponseMock,
  storeEpicGameDataInputMock,
  userId,
} from './mocks/store-epic-data.mocks';
jest.mock('axios');

describe('EpicGamesService', () => {
  let service: EpicGamesService;
  let userRepository: jest.Mocked<AbstractUserRepository>;

  beforeAll(() => {
    const { unit, unitRef } = TestBed.create(EpicGamesService).compile();

    service = unit;

    // @ts-ignore
    userRepository = unitRef.get(AbstractUserRepository);
  });

  describe('sendEpicTokenRequest', () => {
    it('should throw TGMDExternalServiceException if token data is not retrieved', async () => {
      //arrange

      jest.spyOn(axios, 'post').mockResolvedValue({ data: {} });

      expect(async () => {
        //act
        await service.sendEpicTokenRequest(sendEpicTokenRequestInputMock);

        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return Epic games response on success', async () => {
      //arrange

      jest
        .spyOn(axios, 'post')
        .mockResolvedValue({ data: { epicGamesTokenResponseMock } });

      //act
      const result = await service.sendEpicTokenRequest(
        sendEpicTokenRequestInputMock,
      );

      expect(result).toEqual({ epicGamesTokenResponseMock });
    });
  });

  describe('getEpicGamesUser', () => {
    it('should throw TGMDExternalServiceException if user data is not retrieved', async () => {
      //arrange

      const { accessToken, accountId } = getEpicGamesUserInputMock;

      jest.spyOn(axios, 'get').mockResolvedValue({ data: [] });

      expect(async () => {
        //act
        await service.getEpicGamesUser(accessToken, accountId);

        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return Epic games response on success', async () => {
      //arrange

      const { accessToken, accountId } = getEpicGamesUserInputMock;

      jest
        .spyOn(axios, 'get')
        .mockResolvedValue({ data: [{ epicGamesUserResponseMock }] });

      //act
      const result = await service.getEpicGamesUser(accessToken, accountId);

      expect(result).toEqual({ epicGamesUserResponseMock });
    });
  });

  describe('storeEpicData', () => {
    it('should throw TGMDNotFoundException if user is not found in the database', async () => {
      //arrange

      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await service.storeEpicData(userId, storeEpicGameDataInputMock);

        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return user response on success', async () => {
      //arrange

      userRepository.findOne.mockResolvedValue(storeEpicDataUserResponseMock);

      userRepository.updateOneById.mockResolvedValue(
        storeEpicDataUserResponseMock,
      );

      //act
      const result = await service.storeEpicData(
        userId,
        storeEpicGameDataInputMock,
      );

      expect(result).toEqual(storeEpicDataUserResponseMock);
    });
  });

  describe('removeEpicAccount', () => {
    it('should throw TGMDConflictException if is no Epic account associated', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce({
        _id: userId,
        epicGamesUsername: null,
      } as User);

      expect(async () => {
        //act
        await service.removeEpicAccount(userId);

        //assert
      }).rejects.toThrow(TGMDConflictException);
    });

    it('should return undefined on success', async () => {
      //arange
      const userId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce({
        _id: userId,
        epicGamesUsername: 'fake-epic-username',
      } as User);

      userRepository.updateOneById.mockResolvedValue(undefined);

      //act
      const result = await service.removeEpicAccount(userId);

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
