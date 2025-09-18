export abstract class AbstractFriendsService {
  abstract deleteAccountFriends(userId: string): Promise<void>;
}
