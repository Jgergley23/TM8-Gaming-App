/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';
import {
  TGMDConflictException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { AbstractMatchRepository } from '../abstract/match.abstract.repository';
import { Match } from '../schemas/match.schema';
import { MatchService } from '../services/match.service';
import { checkForExistingMatchMock } from './mocks/check-for-existing-match.mock';
import { checkIfMatchFeebackGivenMock } from './mocks/check-if-match-feedback-given.mock';
import {
  giveMatchFeedbackUserMock,
  giveMatchUserFeedbackConflictMock,
  giveMatchUserFeedbackMock,
} from './mocks/give-match-user-feedback.mock';

describe('MatchService', () => {
  let matchService: MatchService;
  let userRepository: jest.Mocked<AbstractUserRepository>;
  let matchRepository: jest.Mocked<AbstractMatchRepository>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(MatchService).compile();

    matchService = unit;

    // @ts-ignore
    userRepository = unitRef.get(AbstractUserRepository);
    // @ts-ignore
    matchRepository = unitRef.get(AbstractMatchRepository);
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('giveMatchUserFeedback', () => {
    it('should throw TGMDNotFoundException if match not found', async () => {
      //arrange
      const currentUserId = faker.database.mongodbObjectId();
      const matchId = faker.database.mongodbObjectId();

      matchRepository.findOneLean.mockResolvedValue(undefined);

      //act
      expect(
        async () =>
          await matchService.giveMatchUserFeedback(currentUserId, matchId, 5),
        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDConflictException if feedback was already given', async () => {
      //arrange
      const currentUserId =
        giveMatchUserFeedbackConflictMock.players[0].user.toString();
      const matchId = faker.database.mongodbObjectId();

      matchRepository.findOneLean.mockResolvedValue(
        giveMatchUserFeedbackConflictMock,
      );

      //act
      expect(
        async () =>
          await matchService.giveMatchUserFeedback(currentUserId, matchId, 5),
        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDNotFoundException if matched user not found', async () => {
      //arrange
      const currentUserId =
        giveMatchUserFeedbackMock.players[0].user.toString();
      const matchId = faker.database.mongodbObjectId();

      matchRepository.findOneLean.mockResolvedValue(giveMatchUserFeedbackMock);
      matchRepository.updateOne.mockResolvedValue(undefined);
      userRepository.findOne.mockResolvedValue(undefined);

      //act
      expect(
        async () =>
          await matchService.giveMatchUserFeedback(currentUserId, matchId, 5),
        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if matched user not found', async () => {
      //arrange
      const currentUserId =
        giveMatchUserFeedbackMock.players[0].user.toString();
      const matchId = faker.database.mongodbObjectId();

      matchRepository.findOneLean.mockResolvedValue(giveMatchUserFeedbackMock);
      matchRepository.updateOne.mockResolvedValue(undefined);
      userRepository.findOne.mockResolvedValue(giveMatchFeedbackUserMock);
      giveMatchFeedbackUserMock.save = jest.fn().mockReturnValue(undefined);

      //act
      const result = await matchService.giveMatchUserFeedback(
        currentUserId,
        matchId,
        5,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('checkIfMatchFeedbackGiven', () => {
    it('should throw TGMDNotFoundException if matched user not found', async () => {
      //arrange
      const currentUserId = faker.database.mongodbObjectId();
      const matchedUserId = faker.database.mongodbObjectId();

      matchRepository.findOneLean.mockResolvedValue(undefined);

      //act
      expect(
        async () =>
          await matchService.checkIfMatchFeedbackGiven(
            currentUserId,
            matchedUserId,
          ),
        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return is feedback given on success', async () => {
      //arrange
      const currentUserId =
        checkIfMatchFeebackGivenMock.players[0].user.toString();

      const matchedUserId =
        checkIfMatchFeebackGivenMock.players[1].user.toString();

      matchRepository.findOneLean.mockResolvedValue(
        checkIfMatchFeebackGivenMock,
      );

      //act
      const result = await matchService.checkIfMatchFeedbackGiven(
        currentUserId,
        matchedUserId,
      );

      //assert
      expect(result).toEqual({ feedbackGiven: false });
    });
  });

  describe('deleteUserMatches', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      matchRepository.findManyLean.mockResolvedValue([
        {
          _id: faker.database.mongodbObjectId(),
          game: 'game' as Game,
          players: [],
        } as Match,
      ]);

      matchRepository.deleteMany.mockResolvedValue(undefined);

      //act
      const result = await matchService.deleteUserMatches(userId);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('checkForExistingMatch', () => {
    it('should return is feedback given on success', async () => {
      //arrange
      const currentUserId =
        checkForExistingMatchMock.players[0].user.toString();

      const matchedUserId =
        checkForExistingMatchMock.players[1].user.toString();

      matchRepository.findOneLean.mockResolvedValue(checkForExistingMatchMock);

      //act
      const result = await matchService.checkForExistingMatch(
        currentUserId,
        matchedUserId,
      );

      //assert
      expect(result).toEqual({
        matchExists: true,
        matchId: checkForExistingMatchMock._id.toString(),
      });
    });
  });
});
