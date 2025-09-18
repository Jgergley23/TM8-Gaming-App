import { IUser } from 'src/modules/user/interface/user.interface';

export interface IFriend {
  user: IUser | string;
}

export interface IFriendRecord extends IFriend {
  _id: string;
  user: IUser | string;
  createdAt?: Date;
  updatedAt?: Date;
}

export interface IFriendRequest {
  user: IUser | string;
}

export interface IFriendRequestRecord extends IFriendRequest {
  _id: string;
  user: IUser | string;
  createdAt?: Date;
  updatedAt?: Date;
}

export interface IFriends {
  user: IUser | string;
  friends: IFriendRecord[];
  requests: IFriendRequestRecord[];
}

export interface IFriendsRecord extends IFriends {
  _id: string;
}
