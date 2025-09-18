import { Controller } from '@nestjs/common';

import { ParameterStoreService } from './services/parameter-store.service';

@Controller('parameter-store')
export class ParameterStoreController {
  constructor(private readonly parameterStoreService: ParameterStoreService) {}
}
