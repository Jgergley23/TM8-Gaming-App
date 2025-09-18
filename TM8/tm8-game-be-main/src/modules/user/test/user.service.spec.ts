/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';

import {
  TGMDConflictException,
  TGMDExternalServiceException,
  TGMDForbiddenException,
  TGMDInternalException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { CryptoUtils } from 'src/common/utils/crypto.utils';
import { AbstractActionRepository } from 'src/modules/action/abstract/action.abstract.repository';
import { AbstractActionService } from 'src/modules/action/abstract/action.abstract.service';
import {
  ChatChatServiceToken,
  ChatUserServiceToken,
  IChatChatService,
  IChatUserService,
} from 'src/modules/chat/interface/chat-service.interface';
import {
  EmailServiceResult,
  EmailServiceToken,
  IEmailService,
} from 'src/modules/email/interface/email-service.interface';
import {
  FileStorageServiceToken,
  IFileStorageService,
} from 'src/modules/file-storage/interface/file-storage.service.interface';
import { AbstractFriendsRepository } from 'src/modules/friends/abstract/friends.abstract.repository';
import { AbstractFriendsService } from 'src/modules/friends/abstract/friends.abstract.service';
import { AbstractMatchService } from 'src/modules/match/abstract/match.abstract.service';
import { AbstractMatchmakingResultService } from 'src/modules/matchmaking-result/abstract/matchmaking-result.service.abstract';
import { AbstractNotificationService } from 'src/modules/notification/abstract/notification.abstract.service';
import { AbstractPotentialMatchService } from 'src/modules/potential-match/abstract/potential-match.abstract.service';
import { AbstractUserGameDataRepository } from 'src/modules/user-game-data/abstract/user-game-data.abstract.repository';
import { AbstractUserGameDataService } from 'src/modules/user-game-data/abstract/user-game-data.abstract.service';

import { AbstractUserRepository } from '../abstract/user.abstract.repository';
import { User } from '../schemas/user.schema';
import { UserService } from '../services/user.service';
import {
  addUserGameResponse,
  addUserGameUserResponse,
} from './mocks/add-user-game.mock';
import {
  banUserUpdateFailedResponseMock,
  banUserUpdateSuccessResponseMock,
  banUsersInputMock,
  banUsersResponseMock,
} from './mocks/ban-users.mocks';
import { blockUserUserRepositoryResponse } from './mocks/block-user.mocks';
import { changePasswordUserResponseMock } from './mocks/change-password.mocks';
import {
  checkFriendshipFriendsRepositoryResponse,
  checkFriendshipResult,
  checkFriendshipUserRepositoryResponse,
} from './mocks/check-friendship.mocks';
import {
  createAdminInputMock,
  createdUserMock,
  existingUserMock,
} from './mocks/create-admin.mock';
import {
  deleteOneCorrectResponseMock,
  deleteOneIncorrectResponseMock,
  deleteUserIds,
} from './mocks/delete-many.mock';
import { deleteUserGameResponse } from './mocks/delete-user-game.mocks';
import { findOneMock, findOneResponseMock } from './mocks/find-one.mock';
import {
  getMeResponse,
  getMeUserFriendsRepositoryMock,
  getMeUserGamesGameDataResponse,
  getMeUserResponse,
} from './mocks/get-me-user.mocks';
import {
  getUserGamePreferencesParamMock,
  getUserGamePreferencesParams,
  getUserGamePreferencesResultMock,
} from './mocks/get-user-game-preferences.mock';
import {
  getUserGamesGameDataResponse,
  getUserGamesUserResponse,
  userGamesResponseMock,
} from './mocks/get-user-games.mocks';
import {
  userProfileFriendsRepositoryMock,
  userProfileResponseMock,
  userProfileUserRepositoryResult,
} from './mocks/get-user-profile.mocks';
import {
  reportActionRepositoryResponseMock,
  userReportsMock,
} from './mocks/get-user-reports.mocks';
import {
  listUserFriendsPaginationParamsMock,
  listUserFriendsParamsMock,
  listUserGamesFriendsRepositoryMock,
  listUserGamesUserRepositoryResult,
  userFriendsPaginationResult,
} from './mocks/list-user-friends.mocks';
import {
  emptyListUsersResponseMock,
  listUsersInputMock,
  listUsersResponseMock,
  paginationParamsMock,
  usersResponseMock,
} from './mocks/list-users.mocks';
import { reportUserInput } from './mocks/report-user.mocks';
import {
  resetUserUpdateFailedResponseMock,
  resetUserUpdateSuccessResponseMock,
  resetUsersInputMock,
  resetUsersResponseMock,
} from './mocks/reset-users.mocks';
import {
  setUserAudioIntroMockAudio,
  setUserAudioIntroUserResponse,
} from './mocks/set-user-audio-intro.mocks';
import {
  setUserNoteResponseMock,
  setUserNoteUpdatedMock,
  userNoteInputMock,
} from './mocks/set-user-note.mocks';
import {
  setUserPhotoMockPhoto,
  setUserPhotoUserResponse,
} from './mocks/set-user-photo.mocks';
import {
  suspendUserUpdateFailedResponseMock,
  suspendUserUpdateSuccessResponseMock,
  suspendUsersInputMock,
  suspendUsersResponseMock,
} from './mocks/suspend-users.mocks';
import {
  updateUsernameCurrentUserResponse,
  updateUsernameExistingUserResponse,
} from './mocks/update-username.mocks';
import {
  addFriendRequesteeConflictRepositoryMock,
  addFriendRequesteeRepositoryMock,
  addFriendRequesteeUserRepositoryResult,
  addFriendRequesterConflictRepositoryMock,
  addFriendRequesterRepositoryMock,
  addFriendRequesterUserRepositoryResult,
} from './mocks/user-add-friend.mocks';
import {
  removeFriendRequesteeNotFoundRepositoryMock,
  removeFriendRequesteeRepositoryMock,
  removeFriendRequesteeUserRepositoryResult,
  removeFriendRequesterNotFoundRepositoryMock,
  removeFriendRequesterRepositoryMock,
  removeFriendRequesterUserRepositoryResult,
} from './mocks/user-remove-friend.mocks';
import {
  userSearchUsersMockResult,
  usersSearchResponseMock,
} from './mocks/user-search-users.mocks';
import {
  warnUserUpdateFailedResponseMock,
  warnUserUpdateSuccessResponseMock,
  warnUsersInputMock,
  warnUsersResponseMock,
} from './mocks/warn-users.mocks';

describe('UserService', () => {
  let userService: UserService;
  let userRepository: jest.Mocked<AbstractUserRepository>;
  let userGameDataRepository: jest.Mocked<AbstractUserGameDataRepository>;
  let actionRepository: jest.Mocked<AbstractActionRepository>;
  let friendsRepository: jest.Mocked<AbstractFriendsRepository>;
  let emailService: jest.Mocked<IEmailService>;
  let fileStorageService: jest.Mocked<IFileStorageService>;
  let actionService: jest.Mocked<AbstractActionService>;
  let userGameDataService: jest.Mocked<AbstractUserGameDataService>;
  let friendsService: jest.Mocked<AbstractFriendsService>;
  let matchService: jest.Mocked<AbstractMatchService>;
  let potentialMatchService: jest.Mocked<AbstractPotentialMatchService>;
  let matchmakingResultService: jest.Mocked<AbstractMatchmakingResultService>;
  let notificationService: jest.Mocked<AbstractNotificationService>;
  let chatService: jest.Mocked<IChatChatService>;
  let chatUserService: jest.Mocked<IChatUserService>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(UserService).compile();

    userService = unit;

    // @ts-ignore
    userRepository = unitRef.get(AbstractUserRepository);
    // @ts-ignore
    userGameDataRepository = unitRef.get(AbstractUserGameDataRepository);
    // @ts-ignore
    actionRepository = unitRef.get(AbstractActionRepository);
    // @ts-ignore
    friendsRepository = unitRef.get(AbstractFriendsRepository);
    emailService = unitRef.get(EmailServiceToken);
    fileStorageService = unitRef.get(FileStorageServiceToken);
    // @ts-ignore
    actionService = unitRef.get(AbstractActionService);
    // @ts-ignore
    userGameDataService = unitRef.get(AbstractUserGameDataService);
    // @ts-ignore
    friendsService = unitRef.get(AbstractFriendsService);
    // @ts-ignore
    potentialMatchService = unitRef.get(AbstractPotentialMatchService);
    // @ts-ignore
    matchService = unitRef.get(AbstractMatchService);
    // @ts-ignore
    matchmakingResultService = unitRef.get(AbstractMatchmakingResultService);
    // @ts-ignore
    notificationService = unitRef.get(AbstractNotificationService);
    // @ts-ignore
    chatService = unitRef.get(ChatChatServiceToken);
    // @ts-ignore
    chatUserService = unitRef.get(ChatUserServiceToken);
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('listUsers', () => {
    it('should return empty user list if no matched users found', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(null);
      userRepository.count.mockResolvedValue(0);

      //act
      expect(
        await userService.listUsers(listUsersInputMock, paginationParamsMock),

        //assert
      ).toEqual(emptyListUsersResponseMock);
    });

    it('should return a list of users', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(usersResponseMock);
      userRepository.count.mockResolvedValue(1);

      //act
      const result = await userService.listUsers(
        listUsersInputMock,
        paginationParamsMock,
      );

      //assert
      expect(result).toEqual(listUsersResponseMock);
    });
  });

  describe('findOne', () => {
    it('should throw TGMDNotFoundException if user is not found', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () => await userService.findOne(findOneMock),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return user response', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(findOneResponseMock);

      //act
      const result = await userService.findOne(findOneMock);

      //assert
      expect(result).toEqual(findOneResponseMock);
    });
  });

  describe('getUserGamePreferences', () => {
    it('should return empty array if game preferences not found', async () => {
      //arrange
      userGameDataRepository.findManyLean.mockResolvedValue([]);

      //act
      const result = await userService.getUserGamePreferences(
        getUserGamePreferencesParamMock,
        getUserGamePreferencesParams,
      );

      //assert
      expect(result).toEqual([]);
    });

    it('should return user game preferences response', async () => {
      //arrange
      userGameDataRepository.findManyLean.mockResolvedValue(
        getUserGamePreferencesResultMock,
      );

      //act
      const result = await userService.getUserGamePreferences(
        getUserGamePreferencesParamMock,
        getUserGamePreferencesParams,
      );

      //assert
      expect(result).toEqual(getUserGamePreferencesResultMock);
    });
  });

  describe('warnUsers', () => {
    it('should throw TGMDNotFoundException if user(s) not found', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue([]);

      //act
      expect(
        async () => {
          await userService.warnUsers(warnUsersInputMock);
        },

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if users not updated', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(warnUsersResponseMock);
      userRepository.updateMany.mockResolvedValue(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        warnUserUpdateFailedResponseMock as any,
      );

      //act
      expect(
        async () => {
          await userService.warnUsers(warnUsersInputMock);
        },

        //assert
      ).rejects.toThrow(TGMDInternalException);
    });

    it('should return updated users response', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(warnUsersResponseMock);
      userRepository.updateMany.mockResolvedValue(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        warnUserUpdateSuccessResponseMock as any,
      );
      userRepository.findManyLean.mockResolvedValue(warnUsersResponseMock);

      //act
      const result = await userService.warnUsers(warnUsersInputMock);

      //assert
      expect(result).toEqual(warnUsersResponseMock);
    });
  });

  describe('banUsers', () => {
    it('should throw TGMDNotFoundException if user(s) not found', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue([]);

      //act
      expect(
        async () => {
          await userService.banUsers(banUsersInputMock);
        },

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDInternalException if user update failed', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(banUsersResponseMock);
      userRepository.updateMany.mockResolvedValue(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        banUserUpdateFailedResponseMock as any,
      );

      //act
      expect(
        async () => {
          await userService.banUsers(banUsersInputMock);
        },

        //assert
      ).rejects.toThrow(TGMDInternalException);
    });

    it('should return updated users response', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(banUsersResponseMock);
      userRepository.updateMany.mockResolvedValue(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        banUserUpdateSuccessResponseMock as any,
      );
      userRepository.findManyLean.mockResolvedValue(banUsersResponseMock);
      notificationService.createAndSendBanNotifications.mockResolvedValue();

      //act
      const result = await userService.banUsers(banUsersInputMock);

      //assert
      expect(result).toEqual(banUsersResponseMock);
    });
  });

  describe('suspendUsers', () => {
    it('should throw TGMDNotFoundException if user(s) not found', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue([]);

      //act
      expect(
        async () => {
          await userService.suspendUsers(suspendUsersInputMock);
        },

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDInternalException if updated users not updated', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(suspendUsersResponseMock);
      userRepository.updateMany.mockResolvedValue(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        suspendUserUpdateFailedResponseMock as any,
      );

      //act
      expect(
        async () => {
          await userService.suspendUsers(suspendUsersInputMock);
        },

        //assert
      ).rejects.toThrow(TGMDInternalException);
    });

    it('should return updated users response', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(suspendUsersResponseMock);
      userRepository.updateMany.mockResolvedValue(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        suspendUserUpdateSuccessResponseMock as any,
      );
      userRepository.findManyLean.mockResolvedValue(suspendUsersResponseMock);
      notificationService.createAndSendSuspendNotifications.mockResolvedValue();

      //act
      const result = await userService.suspendUsers(suspendUsersInputMock);

      //assert
      expect(result).toEqual(suspendUsersResponseMock);
    });
  });

  describe('resetUsers', () => {
    it('should throw TGMDNotFoundException if user(s) not found', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue([]);

      //act
      expect(
        async () => {
          await userService.resetUsers(resetUsersInputMock);
        },

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDInternalException if user update failed', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(resetUsersResponseMock);
      userRepository.updateMany.mockResolvedValue(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        resetUserUpdateFailedResponseMock as any,
      );

      //act
      expect(
        async () => {
          await userService.resetUsers(resetUsersInputMock);
        },

        //assert
      ).rejects.toThrow(TGMDInternalException);
    });

    it('should return updated users response', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(resetUsersResponseMock);
      userRepository.updateMany.mockResolvedValue(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        resetUserUpdateSuccessResponseMock as any,
      );
      userRepository.findManyLean.mockResolvedValue(resetUsersResponseMock);

      //act
      const result = await userService.resetUsers(resetUsersInputMock);

      //assert
      expect(result).toEqual(resetUsersResponseMock);
    });
  });

  describe('setUserNote', () => {
    it('should throw TGMDNotFoundException if user not found', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () => {
          await userService.setUserNote(userId, userNoteInputMock);
        },

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return updated users response', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue(setUserNoteResponseMock);
      userRepository.updateOneById.mockResolvedValue(setUserNoteUpdatedMock);

      //act
      const result = await userService.setUserNote(userId, userNoteInputMock);

      //assert
      expect(result).toEqual(setUserNoteUpdatedMock);
    });
  });

  describe('getUserReports', () => {
    it('should return empty array if actions not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();

      actionRepository.findOneLeanWithReporter.mockResolvedValue(null);

      //act
      const result = await userService.getUserReports(userId);

      //assert
      expect(result).toEqual([]);
    });

    it('should return updated users response', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();

      actionRepository.findOneLeanWithReporter.mockResolvedValue(
        reportActionRepositoryResponseMock,
      );

      //act
      const result = await userService.getUserReports(userId);

      //assert
      expect(result).toEqual(userReportsMock);
    });
  });

  describe('findUsersByUsername', () => {
    it('should return empty user list if no matched username found', async () => {
      //arrange

      const usernameInput = faker.internet.userName();

      userRepository.findManyLean.mockResolvedValue([]);

      //act
      expect(
        await userService.findManyByUsername(usernameInput),

        //assert
      ).toEqual([]);
    });

    it('should return an array of matched users', async () => {
      //arrange

      const usernameInput = faker.internet.userName();

      userRepository.findManyLean.mockResolvedValue(usersResponseMock);

      //act
      const result = await userService.findManyByUsername(usernameInput);

      //assert
      expect(result).toEqual(usersResponseMock);
    });
  });

  describe('deleteMany', () => {
    it('should throw TGMDNotFoundException if user is not found', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue([]);

      //act
      expect(
        async () => await userService.deleteUsers(deleteUserIds),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if delete is not performed on admin role', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(
        deleteOneIncorrectResponseMock,
      );

      //act
      expect(
        async () => await userService.deleteUsers(deleteUserIds),

        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should return undefined on success', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(
        deleteOneCorrectResponseMock,
      );

      userRepository.deleteMany.mockResolvedValue(1);

      //act
      const result = await userService.deleteUsers(deleteUserIds);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('createAdmin', () => {
    it('should throw TGMDConflictException if user with same email exists', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(existingUserMock);

      //act
      expect(
        async () => await userService.createAdmin(createAdminInputMock),

        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDExternalServiceException if email sending fails', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(null);
      userRepository.createOne.mockResolvedValue(createdUserMock);

      emailService.sendEmailAdminAccountCreated.mockResolvedValue(
        EmailServiceResult.FAIL,
      );

      await expect(async () => {
        //act
        await userService.createAdmin(createAdminInputMock);

        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return empty response if admin creation succeeds', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(null);
      userRepository.createOne.mockResolvedValue(createdUserMock);

      emailService.sendEmailAdminAccountCreated.mockResolvedValue(
        EmailServiceResult.SUCCESS,
      );

      //act
      const result = await userService.createAdmin(createAdminInputMock);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('addUserGame', () => {
    it('should throw TGMDNotFoundException if user is not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const game = 'game';
      userRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () => await userService.addUserGame(userId, game),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDConflictException if user game is already added', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const game = 'game';
      userRepository.findOneLean.mockResolvedValue(addUserGameUserResponse);
      userGameDataRepository.findOneLean.mockResolvedValue(addUserGameResponse);

      //act
      expect(
        async () => await userService.addUserGame(userId, game),

        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should return undefined if game is successfully added to user', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const game = 'game';

      userRepository.findOneLean.mockResolvedValue(addUserGameUserResponse);
      userGameDataRepository.findOneLean.mockResolvedValue(null);
      userGameDataRepository.createOne.mockResolvedValue(addUserGameResponse);

      //act
      const result = await userService.addUserGame(userId, game);

      expect(result).toEqual(undefined);
    });
  });

  describe('deleteUserGame', () => {
    it('should throw TGMDNotFoundException if user game data is not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const game = 'game';
      userGameDataRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () => await userService.deleteUserGame(userId, game),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined if game is successfully deleted from user', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const game = 'game';

      userGameDataRepository.findOneLean.mockResolvedValue(
        deleteUserGameResponse,
      );
      userGameDataRepository.deleteOne.mockResolvedValue(
        deleteUserGameResponse,
      );

      //act
      const result = await userService.deleteUserGame(userId, game);

      expect(result).toEqual(undefined);
    });
  });

  describe('userSearchUsers', () => {
    it('should return empty user list if no matched username found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const usernameInput = faker.internet.userName();

      userRepository.findManyLean.mockResolvedValue([]);

      friendsRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        await userService.searchUsers(userId, usernameInput),

        //assert
      ).toEqual([]);
    });

    it('should return an array of matched users', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const usernameInput = faker.internet.userName();

      userRepository.findManyLean.mockResolvedValue(usersSearchResponseMock);

      friendsRepository.findOneLean.mockResolvedValue(null);

      actionRepository.findOneLean.mockResolvedValue(null);

      //act
      const result = await userService.searchUsers(userId, usernameInput);

      //assert
      expect(result).toEqual(userSearchUsersMockResult);
    });
  });

  describe('userAddFriend', () => {
    it('should throw TGMDNotFoundException if requestee user not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const friendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce(null);

      //act
      expect(
        async () => await userService.userAddFriend(userId, friendId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if requestee user not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const friendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce(
        addFriendRequesteeUserRepositoryResult,
      );

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserService.prototype as any, 'checkIfUsersAreBlocked')
        .mockResolvedValue(true);

      //act
      expect(
        async () => await userService.userAddFriend(userId, friendId),

        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDConflictException if requester already has requestee as friend', async () => {
      //arrange

      const userId = addFriendRequesterUserRepositoryResult._id;
      const friendId = addFriendRequesteeUserRepositoryResult._id;

      userRepository.findOneLean.mockResolvedValueOnce(
        addFriendRequesteeUserRepositoryResult,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        addFriendRequesterConflictRepositoryMock,
      );

      //act
      expect(
        async () => await userService.userAddFriend(userId, friendId),

        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDConflictException if requestee already has requester as friend', async () => {
      //arrange

      const userId = addFriendRequesteeUserRepositoryResult._id;
      const friendId = addFriendRequesterUserRepositoryResult._id;

      userRepository.findOneLean.mockResolvedValueOnce(
        addFriendRequesteeUserRepositoryResult,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        addFriendRequesteeConflictRepositoryMock,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        addFriendRequesterConflictRepositoryMock,
      );

      //act
      expect(
        async () => await userService.userAddFriend(userId, friendId),

        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should return undefined on successfull adding of friend', async () => {
      //arrange
      const userId = addFriendRequesteeUserRepositoryResult._id;
      const friendId = addFriendRequesterUserRepositoryResult._id;

      userRepository.findOneLean.mockResolvedValueOnce(
        addFriendRequesteeUserRepositoryResult,
      );

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserService.prototype as any, 'checkIfUsersAreBlocked')
        .mockResolvedValue(false);

      friendsRepository.findOne.mockResolvedValue(
        addFriendRequesteeRepositoryMock,
      );

      friendsRepository.updateOneById.mockResolvedValue(undefined);

      friendsRepository.findOne.mockResolvedValueOnce(
        addFriendRequesterRepositoryMock,
      );

      friendsRepository.updateOneById.mockResolvedValue(undefined);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserService.prototype as any, 'sendFriendAddedNotification')
        .mockResolvedValue(undefined);

      //act
      const result = await userService.userAddFriend(userId, friendId);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('userRemoveFriend', () => {
    it('should throw TGMDNotFoundException if requester user not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const unfriendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () => await userService.userRemoveFriend(userId, unfriendId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if requestee user not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const unfriendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesterUserRepositoryResult,
      );
      userRepository.findOneLean.mockResolvedValueOnce(null);

      //act
      expect(
        async () => await userService.userRemoveFriend(userId, unfriendId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if user not found in requester friend list', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const unfriendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesterUserRepositoryResult,
      );
      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesteeUserRepositoryResult,
      );

      friendsRepository.findOne.mockResolvedValueOnce(null);

      //act
      expect(
        async () => await userService.userRemoveFriend(userId, unfriendId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if user not found in requester friend list', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const unfriendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesterUserRepositoryResult,
      );
      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesteeUserRepositoryResult,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      //act
      expect(
        async () => await userService.userRemoveFriend(userId, unfriendId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if user not found in requester friend list', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const unfriendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesterUserRepositoryResult,
      );
      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesteeUserRepositoryResult,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        removeFriendRequesterNotFoundRepositoryMock,
      );

      //act
      expect(
        async () => await userService.userRemoveFriend(userId, unfriendId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if user not found in requestee friend list', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const unfriendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesterUserRepositoryResult,
      );
      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesteeUserRepositoryResult,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      friendsRepository.updateOneById.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        removeFriendRequesteeNotFoundRepositoryMock,
      );

      //act
      expect(
        async () => await userService.userRemoveFriend(userId, unfriendId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if user not found in requestee friend list', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const unfriendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesterUserRepositoryResult,
      );
      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesteeUserRepositoryResult,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      friendsRepository.updateOneById.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      friendsRepository.findOne.mockResolvedValueOnce(null);

      //act
      expect(
        async () => await userService.userRemoveFriend(userId, unfriendId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if user not found in requestee friend list', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const unfriendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesterUserRepositoryResult,
      );
      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesteeUserRepositoryResult,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      friendsRepository.updateOneById.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        removeFriendRequesteeNotFoundRepositoryMock,
      );

      //act
      expect(
        async () => await userService.userRemoveFriend(userId, unfriendId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if user not found in requestee friend list', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const unfriendId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesterUserRepositoryResult,
      );
      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesteeUserRepositoryResult,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      friendsRepository.updateOneById.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      friendsRepository.findOne.mockResolvedValueOnce(
        removeFriendRequesteeRepositoryMock,
      );

      friendsRepository.updateOneById.mockResolvedValueOnce(
        removeFriendRequesteeRepositoryMock,
      );

      //act
      expect(
        async () => await userService.userRemoveFriend(userId, unfriendId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined on success', async () => {
      //arrange
      jest.clearAllMocks();
      const userId = removeFriendRequesterUserRepositoryResult._id;
      const unfriendId = removeFriendRequesteeUserRepositoryResult._id;

      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesterUserRepositoryResult,
      );
      userRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesteeUserRepositoryResult,
      );

      friendsRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      friendsRepository.updateOneById.mockResolvedValueOnce(
        removeFriendRequesterRepositoryMock,
      );

      friendsRepository.findOneLean.mockResolvedValueOnce(
        removeFriendRequesteeRepositoryMock,
      );

      friendsRepository.updateOneById.mockResolvedValueOnce(
        removeFriendRequesteeRepositoryMock,
      );

      //act
      const result = await userService.userRemoveFriend(userId, unfriendId);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('userProfile', () => {
    it('should throw TGMDNotFoundException if user profile not found', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const currentUserId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () => await userService.getUserProfile(userId, currentUserId),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDForbiddenException if user is blocked', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const currentUserId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue(
        userProfileUserRepositoryResult,
      );

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserService.prototype as any, 'checkIfUsersAreBlocked')
        .mockResolvedValue(true);

      //act
      await expect(
        async () => await userService.getUserProfile(userId, currentUserId),

        //assert
      ).rejects.toThrow(TGMDForbiddenException);
    });

    it('should return user profile', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const currentUserId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue(
        userProfileUserRepositoryResult,
      );

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserService.prototype as any, 'checkIfUsersAreBlocked')
        .mockResolvedValue(false);

      friendsRepository.findOneLean.mockResolvedValue(
        userProfileFriendsRepositoryMock,
      );

      //act
      const result = await userService.getUserProfile(userId, currentUserId);

      //assert
      expect(result).toEqual(userProfileResponseMock);
    });
  });

  describe('checkFriendship', () => {
    it('should throw TGMDNotFoundException if report target user is not found', async () => {
      //arrange
      const currentUserId = faker.database.mongodbObjectId();
      const checkUserId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue(null);

      expect(
        async () =>
          await userService.checkFriendship(currentUserId, checkUserId),
        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return check result on success', async () => {
      //arrange
      const currentUserId = faker.database.mongodbObjectId();
      const checkUserId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue(
        checkFriendshipUserRepositoryResponse,
      );
      friendsRepository.findOneLean.mockResolvedValue(
        checkFriendshipFriendsRepositoryResponse,
      );

      //act
      const result = await userService.checkFriendship(
        currentUserId,
        checkUserId,
      );

      //assert
      expect(result).toEqual(checkFriendshipResult);
    });
  });

  describe('listUserFriends', () => {
    it('should return empty pagination response if user has no friends', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      friendsRepository.findOneLean.mockResolvedValue(null);

      const result = await userService.listUserFriends(
        userId,
        listUserFriendsParamsMock,
        listUserFriendsPaginationParamsMock,
      );

      //assert
      expect(result).toEqual(
        new PaginationModel([], listUserFriendsPaginationParamsMock, 0),
      );
    });

    it('should return pagination response on success', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      friendsRepository.findOneLean.mockResolvedValue(
        listUserGamesFriendsRepositoryMock,
      );

      userRepository.findManyLean.mockResolvedValue(
        listUserGamesUserRepositoryResult,
      );

      userRepository.count.mockResolvedValue(expect.any(Number));

      //act
      const result = await userService.listUserFriends(
        userId,
        listUserFriendsParamsMock,
        listUserFriendsPaginationParamsMock,
      );

      //assert
      expect(result).toEqual(userFriendsPaginationResult);
    });
  });

  describe('reportUser', () => {
    it('should throw TGMDNotFoundException if report target user is not found', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () => await userService.reportUser(reportUserInput),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined on success', async () => {
      //arrang

      userRepository.findOneLean.mockResolvedValue(
        blockUserUserRepositoryResponse,
      );
      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserService.prototype as any, 'addReportToReporter')
        .mockResolvedValue(undefined);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(UserService.prototype as any, 'addReportToTargetUser')
        .mockResolvedValue(undefined);

      //act
      const result = await userService.reportUser(reportUserInput);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('getUserGames', () => {
    it('should throw TGMDNotFoundException if user not found', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () => await userService.getUserGames(userId),
        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return user games on success', async () => {
      //arrange
      const userId = getUserGamesUserResponse._id;

      userRepository.findOneLean.mockResolvedValue(getUserGamesUserResponse);

      userGameDataRepository.findManyLean.mockResolvedValue(
        getUserGamesGameDataResponse,
      );

      //act
      const result = await userService.getUserGames(userId);

      //assert
      expect(result).toEqual(userGamesResponseMock);
    });
  });

  describe('setUserPhoto', () => {
    it('should return photo key on success', async () => {
      //arrange
      const userId = setUserPhotoUserResponse._id;

      userRepository.findOneLean.mockResolvedValue(setUserPhotoUserResponse);

      fileStorageService.delete.mockResolvedValue(undefined);

      fileStorageService.upload.mockResolvedValue(undefined);

      userRepository.updateOneById.mockResolvedValue(setUserPhotoUserResponse);

      chatUserService.upsertUser.mockResolvedValue(undefined);

      //act
      const result = await userService.setUserPhoto(
        userId,
        setUserPhotoMockPhoto,
      );

      //assert
      expect(result).toEqual({ key: expect.any(String) });
    });
  });

  describe('getMeUser', () => {
    it('should return me user response on success', async () => {
      //arrange
      const userId = getMeUserResponse._id;

      userRepository.findOneLean.mockResolvedValue(getMeUserResponse);

      friendsRepository.findOneLean.mockResolvedValue(
        getMeUserFriendsRepositoryMock,
      );

      userGameDataRepository.findManyLean.mockResolvedValue(
        getMeUserGamesGameDataResponse,
      );

      //act
      const result = await userService.getMeUser(userId);

      //assert
      expect(result).toEqual(getMeResponse);
    });
  });

  describe('setUserAudioIntro', () => {
    it('should return audio intro key on success', async () => {
      //arrange
      const userId = setUserAudioIntroUserResponse._id;

      userRepository.findOneLean.mockResolvedValue(setUserPhotoUserResponse);

      fileStorageService.delete.mockResolvedValue(undefined);

      fileStorageService.upload.mockResolvedValue(undefined);

      userRepository.updateOneById.mockResolvedValue(setUserPhotoUserResponse);

      //act
      const result = await userService.setUserAudioIntro(
        userId,
        setUserAudioIntroMockAudio,
      );

      //assert
      expect(result).toEqual({ key: expect.any(String) });
    });
  });

  describe('updateUsername', () => {
    it('should throw TGMDConflictException if new username is same as old', async () => {
      //arrange
      const userId = updateUsernameCurrentUserResponse._id;

      userRepository.findOneLean.mockResolvedValueOnce(
        updateUsernameCurrentUserResponse,
      );

      expect(
        async () =>
          //act
          await userService.updateUsername(userId, {
            username: 'fake-old-username',
          }),
        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDConflictException if new username is already in use', async () => {
      //arrange
      const userId = updateUsernameCurrentUserResponse._id;

      userRepository.findOneLean.mockResolvedValueOnce(
        updateUsernameCurrentUserResponse,
      );

      userRepository.findOneLean.mockResolvedValueOnce(
        updateUsernameExistingUserResponse,
      );

      expect(
        async () =>
          //act
          await userService.updateUsername(userId, {
            username: 'fake-existing-username',
          }),
        //assert
      ).rejects.toThrow(TGMDConflictException);
    });

    it('should return undefined on success', async () => {
      //arrange
      const userId = updateUsernameCurrentUserResponse._id;

      userRepository.findOneLean.mockResolvedValueOnce(
        updateUsernameCurrentUserResponse,
      );

      userRepository.findOneLean.mockResolvedValueOnce(null);

      userRepository.updateOneById.mockResolvedValue(undefined);

      //act
      const result = await userService.updateUsername(userId, {
        username: 'fake-new-username',
      });

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('changeEmail', () => {
    it('should throw TGMDConflictException if user inputs their current email', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue({
        email: 'fake-email',
      } as User);

      //assert
      expect(async () => {
        //act
        await userService.changeEmail(userId, {
          email: 'fake-email',
        });
      }).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDConflictException if new email is alredy in use', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValue({
        email: 'some-email',
      } as User);

      userRepository.findOneLean.mockResolvedValue({
        email: 'fake-email',
      } as User);

      //assert
      expect(async () => {
        //act
        await userService.changeEmail(userId, {
          email: 'fake-email',
        });
      }).rejects.toThrow(TGMDConflictException);
    });

    it('should return undefined on success', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userRepository.findOneLean.mockResolvedValueOnce({
        email: 'some-email',
      } as User);

      userRepository.findOneLean.mockResolvedValueOnce(null);

      emailService.sendEmailUserEmailChange.mockResolvedValue(
        EmailServiceResult.SUCCESS,
      );

      userRepository.updateOneById.mockResolvedValue(undefined);

      //act
      const result = await userService.changeEmail(userId, {
        email: 'fake-email',
      });

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('confirmEmailChange', () => {
    it('should throw TGMDNotFoundException if user with the provided code is not found', async () => {
      //arrange

      userRepository.findOneLean.mockResolvedValue(null);

      //assert
      expect(async () => {
        //act
        await userService.confirmEmailChange({
          code: faker.string.alphanumeric(7),
        });
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined on success', async () => {
      //arrange
      const codeInput = {
        code: faker.string.alphanumeric(7),
      };

      userRepository.findOneLean.mockResolvedValueOnce({
        emailChangeCode: codeInput.code,
        changeEmailRequested: true,
      } as User);

      userRepository.updateOneById.mockResolvedValue(undefined);

      //act
      const result = await userService.confirmEmailChange(codeInput);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('changePassword', () => {
    it('should throw TGMDForbiddenException if current user password is wrong', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userRepository.findOne.mockResolvedValue(changePasswordUserResponseMock);

      jest.spyOn(CryptoUtils, 'validateHash').mockResolvedValue(false);

      //assert
      expect(async () => {
        //act
        await userService.changePassword(userId, {
          oldPassword: 'fake-password',
          newPassword: 'fake-new-password',
        });
      }).rejects.toThrow(TGMDForbiddenException);
    });

    it('should return undefined on success', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userRepository.findOne.mockResolvedValue(changePasswordUserResponseMock);

      jest.spyOn(CryptoUtils, 'validateHash').mockResolvedValue(true);

      changePasswordUserResponseMock.password = 'fake-new-password';
      changePasswordUserResponseMock.save = jest
        .fn()
        .mockResolvedValue(undefined);

      //act
      const result = await userService.changePassword(userId, {
        oldPassword: 'fake-password',
        newPassword: 'fake-new-password',
      });

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('changeUserInfo', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userRepository.updateOneById.mockResolvedValue(undefined);

      //act
      const result = await userService.changeUserInfo(userId, {
        language: 'fake-language',
        gender: 'fake-gender',
        description: 'fake-description',
        dateOfBirth: '2000-01-01',
        country: 'fake-country',
        regions: ['fake-region'],
      });

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('deleteAccount', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      friendsService.deleteAccountFriends.mockResolvedValue(undefined);

      actionService.deleteUserRelatedInboundActions.mockResolvedValue(
        undefined,
      );

      actionService.deleteUserRelatedOutboundActions.mockResolvedValue(
        undefined,
      );

      actionService.deleteUserActions.mockResolvedValue(undefined);

      userGameDataService.deleteUserGameData.mockResolvedValue(undefined);

      notificationService.deleteUserNotifications.mockResolvedValue(undefined);

      matchService.deleteUserMatches.mockResolvedValue(undefined);

      potentialMatchService.deleteUserPotentialMatches.mockResolvedValue(
        undefined,
      );

      matchmakingResultService.deleteUserMatchmakingResults.mockResolvedValue(
        undefined,
      );

      chatService.deleteUserChannels.mockResolvedValue(undefined);

      userRepository.deleteOne.mockResolvedValue(undefined);

      //act
      const result = await userService.deleteAccount(userId);

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
