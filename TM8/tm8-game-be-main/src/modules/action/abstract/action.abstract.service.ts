import { Injectable } from '@nestjs/common';

@Injectable()
export abstract class AbstractActionService {
  abstract deleteUserActions(userId: string): Promise<void>;
  abstract deleteUserRelatedInboundActions(userId: string): Promise<void>;
  abstract deleteUserRelatedOutboundActions(userId: string): Promise<void>;
}
