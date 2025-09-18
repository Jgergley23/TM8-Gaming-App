import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { UserModule } from '../user/user.module';
import { AbstractActionRepository } from './abstract/action.abstract.repository';
import { AbstractActionService } from './abstract/action.abstract.service';
import { Action, ActionSchema } from './schemas/action.schema';
import { ActionSeederService } from './services/action-seeder.service';
import { ActionRepository } from './services/action.repository';
import { ActionService } from './services/action.service';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: Action.name, schema: ActionSchema }]),
    forwardRef(() => UserModule),
  ],
  providers: [
    ActionService,
    ActionRepository,
    {
      provide: AbstractActionService,
      useExisting: ActionService,
    },
    { provide: AbstractActionRepository, useExisting: ActionRepository },
    ActionSeederService,
  ],
  exports: [AbstractActionRepository, AbstractActionService],
})
export class ActionModule {}
