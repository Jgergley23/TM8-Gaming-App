import { ChatServiceResult } from 'src/modules/chat/interface/chat-service.interface';

export class ChatResponse<T> {
  status: ChatServiceResult;
  data: T | null;
  error?: string;
}
