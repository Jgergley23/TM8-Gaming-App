import { Module } from '@nestjs/common';

import { EmailModule } from '../email/email.module';
import { AbstractLandingPageService } from './abstract/landing-page.abstract.service';
import { LandingPageController } from './landing-page.controller';
import { LandingPageService } from './services/landing-page.service';

@Module({
  imports: [EmailModule],
  controllers: [LandingPageController],
  providers: [
    LandingPageService,
    { provide: AbstractLandingPageService, useExisting: LandingPageService },
  ],
})
export class LandingPageModule {}
