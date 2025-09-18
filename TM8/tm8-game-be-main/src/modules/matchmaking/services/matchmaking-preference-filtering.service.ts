import { Injectable } from '@nestjs/common';

import { GamePreferenceKey } from 'src/common/constants';
import { NumberUtils } from 'src/common/utils/number.utils';
import { GamePreferenceValue } from 'src/modules/user-game-data/schemas/game-preference-value.schema';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { AbstractMatchmakingPreferenceFilteringService } from '../abstract/matchmaking-preference-filtering.abstract.service';

@Injectable()
export class MatchmakingPreferenceFilteringService extends AbstractMatchmakingPreferenceFilteringService {
  constructor() {
    super();
  }

  /**
   * Checks for at least one game preference in a type of preference
   * @param currentUserData - current user game preferences
   * @param otherUsersData - other users game preferences
   * @param preferenceKey - key of game preference
   * @returns array of user ids with matched preferences
   */
  getAtLeastOneMatchingPreference(
    currentUserData: UserGameData,
    otherUsersData: UserGameData[],
    preferenceKey: string,
  ): string[] {
    const currentUserPreferences = currentUserData.preferences
      .filter((preference) => preference.key === preferenceKey)
      .flatMap((preference) => preference.values.map((value) => value.key));

    const matchingUserIds: string[] = [];

    otherUsersData.forEach((userData) => {
      const otherUsersPreferences = userData.preferences
        .filter((preference) => preference.key === preferenceKey)
        .flatMap((preference) => preference.values.map((value) => value.key));

      const usersHaveMatchingPreferences = currentUserPreferences.some(
        (preference) => otherUsersPreferences.includes(preference),
      );

      if (usersHaveMatchingPreferences) {
        if (typeof userData.user !== 'string') {
          matchingUserIds.push(userData.user._id);
        }
      }
    });

    return matchingUserIds;
  }

  /**
   * Gets users with matching player type preferences
   * @param currentUserData - current user game preferences
   * @param otherUsersData - other users game preferences
   * @returns array of user ids with matched preferences
   */
  getPlayStyleMatchingPreference(
    currentUserData: UserGameData,
    otherUsersData: UserGameData[],
  ): string[] {
    const matchingUserIds: Set<string> = new Set();

    // Extract playstyle preferences of the current user
    const currentUserPlaystyles = currentUserData.preferences
      .filter((preference) => preference.key === GamePreferenceKey.PlayStyle)
      .flatMap((preference) => preference.values);

    // Iterate through other users' data to find matches
    otherUsersData.forEach((userData) => {
      // Extract playstyle preferences of the other user
      const otherUserPlaystyles = userData.preferences
        .filter((preference) => preference.key === GamePreferenceKey.PlayStyle)
        .flatMap((preference) => preference.values);

      // Check if all playstyles of the other user match the criteria
      if (typeof userData.user !== 'string') {
        // Check if all playstyles of the other user match the current user's playstyles
        if (
          this.allPlaystylesMatch(currentUserPlaystyles, otherUserPlaystyles)
        ) {
          matchingUserIds.add(userData.user._id);
        }
      }
    });
    return Array.from(matchingUserIds);
  }

  /**
   * Checks if all playstyles of the other user match the current user's playstyles
   * @param currentUserPlaystyles - playstyles of the current user
   * @param otherUserPlaystyles - playstyles of the other user
   * @returns boolean indicating if all playstyles match
   */
  private allPlaystylesMatch(
    currentUserPlaystyles: GamePreferenceValue[],
    otherUserPlaystyles: GamePreferenceValue[],
  ): boolean {
    return otherUserPlaystyles.every((otherPlaystyle) =>
      currentUserPlaystyles.some((currentUserPlaystyle) =>
        this.playstylesMatch(currentUserPlaystyle, otherPlaystyle),
      ),
    );
  }

  /**
   * Checks if two playstyles match the criteria
   * @param currentUserPlaystyle - playstyle of the current user
   * @param otherPlaystyle - playstyle of the other user
   * @returns boolean indicating if the playstyles match the criteria
   */
  private playstylesMatch(
    currentUserPlaystyle: GamePreferenceValue,
    otherPlaystyle: GamePreferenceValue,
  ): boolean {
    const isPlaystyleKeyMatch = currentUserPlaystyle.key === otherPlaystyle.key;
    const isNumericValueMatch =
      (NumberUtils.isNumericValueInRange(
        currentUserPlaystyle.numericValue,
        1,
        3,
      ) &&
        NumberUtils.isNumericValueInRange(otherPlaystyle.numericValue, 1, 3)) ||
      (NumberUtils.isNumericValueInRange(
        currentUserPlaystyle.numericValue,
        4,
        5,
      ) &&
        NumberUtils.isNumericValueInRange(otherPlaystyle.numericValue, 4, 5));
    return isPlaystyleKeyMatch && isNumericValueMatch;
  }

  /**
   * Gets game playstyle matches based on preference key mapping
   * @param currentUserData - current user data
   * @param otherUsersData - other users data
   * @returns array of matched user ids
   */
  getMatchingPreferencesBasedOnMapping(
    currentUserData: UserGameData,
    otherUsersData: UserGameData[],
    keyMappings: Record<string, string[]>,
    preferenceKey: string,
  ): string[] {
    const currentUserPreferences = currentUserData.preferences
      .filter((preference) => preference.key === preferenceKey)
      .flatMap((preference) => preference.values.map((value) => value.key));

    const matchingUserIds: string[] = [];

    otherUsersData.forEach((userData) => {
      const otherUsersPreferences = userData.preferences
        .filter((preference) => preference.key === preferenceKey)
        .flatMap((preference) => preference.values.map((value) => value.key));

      const usersHaveMatchingPreferences = currentUserPreferences.some(
        (prefKey) => {
          return otherUsersPreferences.some((otherPref) => {
            return keyMappings[prefKey]?.includes(otherPref);
          });
        },
      );

      if (usersHaveMatchingPreferences) {
        if (typeof userData.user !== 'string') {
          matchingUserIds.push(userData.user._id);
        }
      }
    });

    return matchingUserIds;
  }

  /**
   * Compares arrays of matched preferences and checks for intersections
   * @param arrays - array of user id arrays
   * @returns array of user ids which existed in all input arrays
   */
  getAllMatchingUsers(arrays: string[][]): string[] {
    return arrays.reduce((acc, val) => acc.filter((v) => val.includes(v)));
  }

  /**
   * Checks if the online schedules of two users overlap
   * @param currentUserOnlineSchedule - online schedule of the current user
   * @param otherUserOnlineSchedule - online schedule of the other user
   * @returns boolean indicating if the online schedules overlap
   */
  private checkIfOnlineSchedulesOverlap(
    currentUserOnlineSchedule: GamePreferenceValue[],
    otherUserOnlineSchedule: GamePreferenceValue[],
  ): boolean {
    // Extract the start and end times of the current user's online schedule
    const currentUserOnlineScheduleStart = new Date(
      currentUserOnlineSchedule[0].selectedValue,
    );
    const currentUserOnlineScheduleEnd = new Date(
      currentUserOnlineSchedule[1].selectedValue,
    );

    // Extract the start and end times of the other user's online schedule
    const otherUserOnlineScheduleStart = new Date(
      otherUserOnlineSchedule[0].selectedValue,
    );
    const otherUserOnlineScheduleEnd = new Date(
      otherUserOnlineSchedule[1].selectedValue,
    );

    // Check if the online schedules overlap
    return (
      currentUserOnlineScheduleStart <= otherUserOnlineScheduleEnd &&
      otherUserOnlineScheduleStart <= currentUserOnlineScheduleEnd
    );
  }

  /**
   * Gets users with online schedules matching the current user's preferences
   * @param currentUserData - current user game preferences
   * @param otherUsersData - other users game preferences
   * @returns array of user ids with matched preferences
   */
  getMatchingOnlineSchedulePreferences(
    currentUserData: UserGameData,
    otherUsersData: UserGameData[],
  ): string[] {
    const matchingUserIds: Set<string> = new Set();

    // Extract online schedule from the current user's preferences
    const currentUserOnlineSchedule = currentUserData.preferences
      .filter(
        (preference) => preference.key === GamePreferenceKey.OnlineSchedule,
      )
      .flatMap((preference) => preference.values);

    // If there is no online schedule preference, return all users
    if (currentUserOnlineSchedule.length === 0) {
      otherUsersData.forEach((userData) => {
        if (typeof userData.user !== 'string') {
          matchingUserIds.add(userData.user._id);
        }
      });
      return Array.from(matchingUserIds);
    }

    // If there is an online schedule preference, find users that match the criteria
    otherUsersData.forEach((userData) => {
      // Extract online schedule of the other user
      const otherUserOnlineSchedule = userData.preferences
        .filter(
          (preference) => preference.key === GamePreferenceKey.OnlineSchedule,
        )
        .flatMap((preference) => preference.values);

      // Take the user into consideration only if there exists an online schedule preference
      if (
        otherUserOnlineSchedule.length !== 0 &&
        typeof userData.user !== 'string'
      ) {
        // Check if online schedule of the other user overlaps the current user's online schedule
        if (
          this.checkIfOnlineSchedulesOverlap(
            currentUserOnlineSchedule,
            otherUserOnlineSchedule,
          )
        ) {
          matchingUserIds.add(userData.user._id);
        }
      }
    });
    return Array.from(matchingUserIds);
  }
}
