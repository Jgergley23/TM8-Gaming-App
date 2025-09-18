import { ApiProperty } from '@nestjs/swagger';

import { Game } from 'src/common/constants';

export class UserGameResponse {
  @ApiProperty()
  displayName: string;

  @ApiProperty()
  game: Game;
}

export class UserGamesResponse {
  @ApiProperty()
  userId: string;

  @ApiProperty({ type: [UserGameResponse] })
  games: UserGameResponse[];
}
