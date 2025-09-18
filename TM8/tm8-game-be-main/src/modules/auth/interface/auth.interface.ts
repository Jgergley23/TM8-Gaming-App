export interface IAuth {
  success: boolean;
  accessToken?: string;
  refreshToken?: string;
  username?: string;
  name?: string;
  role?: string;
  id?: string;
  signupType?: string;
  chatToken?: string;
  phoneVerificationRequired?: boolean;
}
