import { faker } from '@faker-js/faker';

import { Game, UserMatchChoice } from 'src/common/constants';
import { Match } from 'src/modules/match/schemas/match.schema';
import { MatchmakingResult } from 'src/modules/matchmaking-result/schemas/matchmaking-result.schema';
import { PotentialMatch } from 'src/modules/potential-match/schemas/potential-match.schema';

export const matchRepositoryResponseMock: Match = {
  _id: faker.database.mongodbObjectId(),
  players: [
    {
      _id: faker.database.mongodbObjectId(),
      user: faker.database.mongodbObjectId(),
      feedback: null,
    },
    {
      _id: faker.database.mongodbObjectId(),
      user: faker.database.mongodbObjectId(),
      feedback: null,
    },
  ],
  game: 'fake-game' as Game,
};

export const matchmakingResultErrorResponseMock: MatchmakingResult = {
  _id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  matches: [faker.database.mongodbObjectId()],
  game: 'fake-game' as Game,
};

export const matchmakingResultResponseMock: MatchmakingResult = {
  _id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  matches: [faker.database.mongodbObjectId()],
  game: 'fake-game' as Game,
};

export const potentialMatchResponseMock: PotentialMatch = {
  _id: faker.database.mongodbObjectId(),
  game: 'fake-game' as Game,
  users: [
    {
      _id: faker.database.mongodbObjectId(),
      user: matchmakingResultResponseMock.user,
      choice: UserMatchChoice.None,
    },
    {
      _id: faker.database.mongodbObjectId(),
      user: matchmakingResultResponseMock.matches[0] as string,
      choice: UserMatchChoice.Accepted,
    },
  ],
};
