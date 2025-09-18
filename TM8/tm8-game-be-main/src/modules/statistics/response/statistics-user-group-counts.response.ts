import { ApiProperty } from '@nestjs/swagger';

export class UserGroupCountsResponse {
  @ApiProperty({ nullable: true })
  allUsers?: number;

  @ApiProperty({ nullable: true })
  apexLegendsPlayers?: number;

  @ApiProperty({ nullable: true })
  callOfDutyPlayers?: number;

  @ApiProperty({ nullable: true })
  fortnitePlayers?: number;

  @ApiProperty({ nullable: true })
  rocketLeaguePlayers?: number;
}
