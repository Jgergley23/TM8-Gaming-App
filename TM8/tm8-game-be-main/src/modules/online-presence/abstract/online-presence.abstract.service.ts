export abstract class AbstractOnlinePresenceService {
  abstract filterOnlineUsers(userIds: string[]): Promise<string[]>;
}
