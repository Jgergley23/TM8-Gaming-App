import { Module } from '@nestjs/common';

import { UserModule } from '../user/user.module';
import { SmsProviderServiceToken } from './interface/sms-provider.interface';
import { TwilioSmsService } from './providers/twilio.service';

@Module({
  imports: [UserModule],
  providers: [
    TwilioSmsService,
    { provide: SmsProviderServiceToken, useExisting: TwilioSmsService },
  ],
  exports: [SmsProviderServiceToken],
})
export class TwilioModule {}
