import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { UserModule } from 'src/modules/user/user.module';

import { UserGameDataModule } from '../user-game-data/user-game-data.module';
import { AbstractStatisticsRepository } from './abstract/statistics.abstract.repository';
import { AbstractStatisticsService } from './abstract/statistics.abstract.service';
import { Statistics, StatisticsSchema } from './schemas/statistics.schema';
import { StatisticsSchedulerService } from './services/statistics-scheduler.service';
import { StatisticsSeederService } from './services/statistics-seeder.service';
import { StatisticsRepository } from './services/statistics.repository';
import { StatisticsService } from './services/statistics.service';
import { StatisticsController } from './statistics.controller';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Statistics.name, schema: StatisticsSchema },
    ]),
    UserModule,
    UserGameDataModule,
  ],
  providers: [
    StatisticsService,
    StatisticsSeederService,
    StatisticsRepository,
    { provide: AbstractStatisticsService, useExisting: StatisticsService },
    {
      provide: AbstractStatisticsRepository,
      useExisting: StatisticsRepository,
    },
    StatisticsSchedulerService,
  ],
  controllers: [StatisticsController],
})
export class StatisticsModule {}
