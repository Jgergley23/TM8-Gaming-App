import { Module } from '@nestjs/common';

import { SendgridModule } from '../sendgrid/sendgrid.module';
import { EmailServiceToken } from './interface/email-service.interface';
import { EmailService } from './providers/email.service';

@Module({
  imports: [SendgridModule],
  providers: [
    EmailService,
    {
      provide: EmailServiceToken,
      useExisting: EmailService,
    },
  ],
  exports: [EmailServiceToken],
})
export class EmailModule {}
