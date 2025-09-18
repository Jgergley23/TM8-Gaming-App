import { Body, Controller, HttpCode, Post } from '@nestjs/common';
import { ApiOkResponse, ApiResponse, ApiTags } from '@nestjs/swagger';

import { TGMDExceptionResponse } from 'src/common/exceptions/custom-exception.response';

import { AbstractLandingPageService } from './abstract/landing-page.abstract.service';
import { ContactFormInput } from './dto/contact-form.input';

@Controller('landing-page')
@ApiTags('Landing Page')
@ApiResponse({
  description: 'Non-2XX response',
  type: TGMDExceptionResponse,
})
export class LandingPageController {
  constructor(
    private readonly landingPageService: AbstractLandingPageService,
  ) {}

  @Post('contact-form')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  sendContactEmail(@Body() contactFormInput: ContactFormInput): Promise<void> {
    return this.landingPageService.sendContactForm(contactFormInput);
  }
}
