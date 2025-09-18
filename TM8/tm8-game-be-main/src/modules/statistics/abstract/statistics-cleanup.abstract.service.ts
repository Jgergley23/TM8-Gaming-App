export abstract class AbstractStatisticsCleanupService {
  abstract cleanupStatistics(): Promise<void>;
}
