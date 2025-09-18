export abstract class AbstractMatchmakingUserSortingService {
  abstract sortMatchmakingResultsByOnlineStatus(
    matchmakingResults: string[],
  ): Promise<string[]>;
}
