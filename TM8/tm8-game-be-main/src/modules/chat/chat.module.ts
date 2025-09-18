import { Module, forwardRef } from '@nestjs/common';

import { StreamChatModule } from '../stream-chat/stream-chat.module';
import { UserModule } from '../user/user.module';
import { ChatController } from './chat.controller';
import {
  ChatChatServiceToken,
  ChatUserServiceToken,
} from './interface/chat-service.interface';
import { ChatChatService } from './services/chat-chat.service';
import { ChatUserService } from './services/chat-user.service';

@Module({
  imports: [StreamChatModule, forwardRef(() => UserModule)],
  controllers: [ChatController],
  providers: [
    ChatChatService,
    ChatUserService,
    { provide: ChatChatServiceToken, useExisting: ChatChatService },
    { provide: ChatUserServiceToken, useExisting: ChatUserService },
  ],
  exports: [ChatChatServiceToken, ChatUserServiceToken],
})
export class ChatModule {}
