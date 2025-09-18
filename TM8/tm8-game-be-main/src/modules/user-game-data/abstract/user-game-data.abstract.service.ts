import { Game } from 'src/common/constants';
import { SetGamePlaytimeInput } from 'src/modules/user-game-data/dto/set-game-playtime.input';

import { SetApexLegendsPreferencesInput } from '../dto/set-apex-legends-preferences.input';
import { SetCallOfDutyPreferencesInput } from '../dto/set-call-of-duty-preferences.input';
import { SetFortnitePreferencesInput } from '../dto/set-fortnite-preferences.input';
import { SetOnlineScheduleInput } from '../dto/set-online-schedule.input';
import { SetRocketLeaguePreferencesInput } from '../dto/set-rocket-league-preferences.input';
import { UserGameData } from '../schemas/user-game-data.schema';

export abstract class AbstractUserGameDataService {
  abstract deleteUserGameData(userId: string): Promise<void>;
  abstract setGamePlaytime(
    userId: string,
    game: Game,
    setGamePlaytimeInput: SetGamePlaytimeInput,
  ): Promise<void>;
  abstract setCallOfDutyPreferences(
    userId: string,
    codPreferencesInput: SetCallOfDutyPreferencesInput,
  ): Promise<UserGameData>;
  abstract setApexLegendsPreferences(
    userId: string,
    apexPreferencesInput: SetApexLegendsPreferencesInput,
  ): Promise<UserGameData>;
  abstract setRocketLeaguePreferences(
    userId: string,
    rocketLeaguePreferencesInput: SetRocketLeaguePreferencesInput,
  ): Promise<UserGameData>;
  abstract setFortnitePreferences(
    userId: string,
    fortnitePreferencesInput: SetFortnitePreferencesInput,
  ): Promise<UserGameData>;
  abstract setOnlineSchedule(
    userId: string,
    game: Game,
    setOnlineScheduleInput: SetOnlineScheduleInput,
  ): Promise<void>;
  abstract deleteOnlineSchedule(userId: string, game: Game): Promise<void>;
}
