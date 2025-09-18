import { Injectable } from '@nestjs/common';
import {
  MongooseModuleOptions,
  MongooseOptionsFactory,
} from '@nestjs/mongoose';

import { MongoConfig } from '../config/env.validation';

@Injectable()
export class MongooseOptions implements MongooseOptionsFactory {
  constructor(private readonly config: MongoConfig) {}

  createMongooseOptions(): MongooseModuleOptions {
    return {
      uri: this.config.URI,
      retryAttempts: this.config.RETRY.ATTEMPTS,
      retryDelay: this.config.RETRY.DELAY,
    };
  }
}
