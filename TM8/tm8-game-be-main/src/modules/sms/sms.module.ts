import { Module } from '@nestjs/common';

import { TwilioModule } from '../twilio/twilio.module';
import { SmsServiceToken } from './interface/sms-service.interface';
import { SmsService } from './providers/sms.service';

@Module({
  imports: [TwilioModule],
  providers: [
    SmsService,
    {
      provide: SmsServiceToken,
      useExisting: SmsService,
    },
  ],
  exports: [SmsServiceToken],
})
export class SmsModule {}
