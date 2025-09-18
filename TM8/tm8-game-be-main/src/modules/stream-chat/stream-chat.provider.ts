import { LoggerService, Provider } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER } from 'nest-winston';
import { StreamChat } from 'stream-chat';

import { StreamChatConfig } from 'src/common/config/env.validation';

import { ChatProviderToken } from './interface/chat-provider.interface';

export const StreamChatProvider: Provider = {
  useFactory: (streamChatConfig: StreamChatConfig, logger: LoggerService) => {
    try {
      const serverClient: StreamChat = StreamChat.getInstance(
        streamChatConfig.KEY,
        streamChatConfig.SECRET,
      );
      return serverClient;
    } catch (error) {
      logger.error(error.message);
    }
  },
  provide: ChatProviderToken,
  inject: [StreamChatConfig, WINSTON_MODULE_NEST_PROVIDER],
};
