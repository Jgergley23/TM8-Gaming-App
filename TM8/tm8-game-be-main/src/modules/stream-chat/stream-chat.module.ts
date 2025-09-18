import { Module } from '@nestjs/common';

import { ActionModule } from '../action/action.module';
import {
  ChatProviderChatServiceToken,
  ChatProviderUserServiceToken,
} from './interface/chat-provider.interface';
import { StreamChatChatService } from './services/stream-chat-chat.service';
import { StreamChatUserService } from './services/stream-chat-user.service';
import { StreamChatProvider } from './stream-chat.provider';

@Module({
  imports: [ActionModule],
  providers: [
    StreamChatProvider,
    StreamChatChatService,
    StreamChatUserService,
    {
      provide: ChatProviderChatServiceToken,
      useExisting: StreamChatChatService,
    },
    {
      provide: ChatProviderUserServiceToken,
      useExisting: StreamChatUserService,
    },
  ],
  exports: [
    StreamChatProvider,
    ChatProviderChatServiceToken,
    ChatProviderUserServiceToken,
  ],
})
export class StreamChatModule {}
