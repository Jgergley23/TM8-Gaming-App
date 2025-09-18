import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { UserModule } from '../user/user.module';
import { AbstractMatchRepository } from './abstract/match.abstract.repository';
import { AbstractMatchService } from './abstract/match.abstract.service';
import { MatchController } from './match.controller';
import { Match, MatchSchema } from './schemas/match.schema';
import { MatchRepository } from './services/match.repository';
import { MatchService } from './services/match.service';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: Match.name, schema: MatchSchema }]),
    forwardRef(() => UserModule),
  ],
  providers: [
    { provide: AbstractMatchService, useClass: MatchService },
    { provide: AbstractMatchRepository, useClass: MatchRepository },
  ],
  controllers: [MatchController],
  exports: [AbstractMatchRepository, AbstractMatchService],
})
export class MatchModule {}
