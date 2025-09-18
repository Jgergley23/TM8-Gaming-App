import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { AbstractFriendsRepository } from './abstract/friends.abstract.repository';
import { AbstractFriendsService } from './abstract/friends.abstract.service';
import { Friends, FriendsSchema } from './schemas/friends.schema';
import { FriendsRepository } from './services/friends.repository';
import { FriendsService } from './services/friends.service';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: Friends.name, schema: FriendsSchema }]),
  ],
  providers: [
    FriendsRepository,
    FriendsService,
    { provide: AbstractFriendsRepository, useClass: FriendsRepository },
    { provide: AbstractFriendsService, useClass: FriendsService },
  ],
  exports: [AbstractFriendsRepository, AbstractFriendsService],
})
export class FriendsModule {}
