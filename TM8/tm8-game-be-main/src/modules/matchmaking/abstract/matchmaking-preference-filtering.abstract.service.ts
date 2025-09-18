import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

export abstract class AbstractMatchmakingPreferenceFilteringService {
  abstract getAtLeastOneMatchingPreference(
    currentUserData: UserGameData,
    otherUsersData: UserGameData[],
    preferenceKey: string,
  ): string[];
  abstract getPlayStyleMatchingPreference(
    currentUserData: UserGameData,
    otherUsersData: UserGameData[],
  ): string[];
  abstract getMatchingPreferencesBasedOnMapping(
    currentUserData: UserGameData,
    otherUsersData: UserGameData[],
    keyMappings: Record<string, string[]>,
    preferenceKey: string,
  ): string[];
  abstract getAllMatchingUsers(arrays: string[][]): string[];
  abstract getMatchingOnlineSchedulePreferences(
    currentUserData: UserGameData,
    otherUsersData: UserGameData[],
  ): string[];
}
