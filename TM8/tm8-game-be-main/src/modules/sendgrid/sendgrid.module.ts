import { Module } from '@nestjs/common';

import { EmailProviderServiceToken } from './interface/email-provider.interface';
import { SendgridEmailService } from './providers/sendgrid.service';

@Module({
  providers: [
    SendgridEmailService,
    {
      provide: EmailProviderServiceToken,
      useExisting: SendgridEmailService,
    },
  ],
  exports: [EmailProviderServiceToken],
})
export class SendgridModule {}
