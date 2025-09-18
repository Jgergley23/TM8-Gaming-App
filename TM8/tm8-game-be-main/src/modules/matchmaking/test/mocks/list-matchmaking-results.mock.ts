import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';
import { MatchmakingResult } from 'src/modules/matchmaking-result/schemas/matchmaking-result.schema';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';
import { User } from 'src/modules/user/schemas/user.schema';

import { MatchmakingResultPaginatedResponse } from '../../response/matchmaking-result.paginated.response';

export const listMatchmakingResultsEmptyResponseMock: MatchmakingResult = {
  _id: faker.database.mongodbObjectId(),
  game: 'fake-game' as Game,
  user: faker.database.mongodbObjectId(),
  matches: [],
};

export const emptyMatchmakingResultPaginationMock: MatchmakingResultPaginatedResponse =
  {
    items: [],
    meta: {
      page: 1,
      limit: 10,
      itemCount: 0,
      pageCount: 0,
      hasNextPage: false,
      hasPreviousPage: false,
    },
  };

export const listMatchmakingResultsResponseMock: MatchmakingResult = {
  _id: faker.database.mongodbObjectId(),
  game: 'fake-game' as Game,
  user: faker.database.mongodbObjectId(),
  matches: [faker.database.mongodbObjectId()],
};

export const userGameDataRepositoryMock: UserGameData[] = [
  {
    _id: faker.database.mongodbObjectId(),
    game: 'fake-game' as Game,
    user: {
      _id: listMatchmakingResultsResponseMock.matches[0],
      photoKey: 'fake-photo-key',
      audioKey: 'fake-audio-key',
      username: 'fake-username',
      dateOfBirth: new Date(),
      country: 'fake-country',
    } as unknown as User,
    preferences: [],
  },
];

export const matchmakingResultPaginationMock: MatchmakingResultPaginatedResponse =
  {
    items: [
      {
        id: (userGameDataRepositoryMock[0].user as User)._id,
        photoKey: (userGameDataRepositoryMock[0].user as User).photoKey,
        audioKey: (userGameDataRepositoryMock[0].user as User).audioKey,
        username: (userGameDataRepositoryMock[0].user as User).username,
        dateOfBirth: (userGameDataRepositoryMock[0].user as User).dateOfBirth,
        country: (userGameDataRepositoryMock[0].user as User).country,
        preferences: userGameDataRepositoryMock[0].preferences,
      },
    ],
    meta: {
      page: 1,
      limit: 10,
      itemCount: 1,
      pageCount: 1,
      hasNextPage: false,
      hasPreviousPage: false,
    },
  };
