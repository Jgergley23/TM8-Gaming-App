export interface IStatistics {
  totalCount: number;
  onboardedCount: number;
}

export interface IStatisticsRecord extends IStatistics {
  _id: string;
}
