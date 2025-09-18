import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Game, Region, UserMatchChoice } from 'src/common/constants';
import { MatchmakingResult } from 'src/modules/matchmaking-result/schemas/matchmaking-result.schema';
import { PotentialMatch } from 'src/modules/potential-match/schemas/potential-match.schema';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';
import { User } from 'src/modules/user/schemas/user.schema';

export const currentUserRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
  regions: ['fake-region' as Region],
} as User;

export const currentUserEmptyGameDataMock: UserGameData = {
  _id: faker.database.mongodbObjectId(),
  game: 'game1' as Game,
  preferences: [],
  user: currentUserRepositoryMock._id,
};

export const currentUserGameDataMock: UserGameData = {
  _id: faker.database.mongodbObjectId(),
  game: 'game1' as Game,
  preferences: [
    {
      key: 'fake-key',
      title: 'fake-title',
      values: [{ key: 'fake-key', selectedValue: 'Fake Key' }],
    },
  ],
  user: { _id: currentUserRepositoryMock._id } as User,
};

export const usersGameDataMock: UserGameData[] = [
  {
    _id: faker.database.mongodbObjectId(),
    game: 'game1' as Game,
    preferences: [
      {
        key: 'fake-key',
        title: 'fake-title',
        values: [{ key: 'fake-key', selectedValue: 'Fake Key' }],
      },
      {
        key: 'play-style',
        title: 'Play Syle',
        values: [
          {
            key: 'aggressive',
            numericValue: 1,
            numericDisplay: 'Aggressive',
          },
        ],
      },
    ],
    user: { _id: faker.database.mongodbObjectId() } as User,
  },
  {
    _id: faker.database.mongodbObjectId(),
    game: 'game1' as Game,
    preferences: [
      {
        key: 'fake-key',
        title: 'fake-title',
        values: [{ key: 'fake-key', selectedValue: 'Fake Key' }],
      },
      {
        key: 'play-style',
        title: 'Play Syle',
        values: [
          {
            key: 'aggressive',
            numericValue: 1,
            numericDisplay: 'Aggressive',
          },
        ],
      },
    ],
    user: { _id: faker.database.mongodbObjectId() } as User,
  },
];

export const gameDataUserIdsMock: string[] = [
  (usersGameDataMock[0].user as User)._id.toString(),
  (usersGameDataMock[1].user as User)._id.toString(),
];

export const algorithmResultRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: currentUserRepositoryMock._id,
  game: 'game1' as Game,
  matches: [faker.database.mongodbObjectId()],
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
} as MatchmakingResult & Document<any, any, MatchmakingResult>;

export const potentialMatchRepositoryMock = [
  {
    _id: faker.database.mongodbObjectId(),
    users: [
      {
        _id: faker.database.mongodbObjectId(),
        user: faker.database.mongodbObjectId(),
        choice: UserMatchChoice.Accepted,
      },
      {
        _id: faker.database.mongodbObjectId(),
        user: faker.database.mongodbObjectId(),
        choice: UserMatchChoice.None,
      },
    ],
    game: 'fake-game' as Game,
  },
] as PotentialMatch[];
