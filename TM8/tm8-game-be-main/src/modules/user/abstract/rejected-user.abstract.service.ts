export abstract class AbstractRejectedUserService {
  abstract cleanupRejectedUsers(): Promise<void>;
}
