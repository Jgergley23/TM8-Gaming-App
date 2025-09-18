export enum EmailServiceResult {
  SUCCESS,
  FAIL,
}

export interface IEmailService {
  sendEmailAdminForgotPassword(
    email: string,
    link: string,
  ): Promise<EmailServiceResult>;
  sendEmailAdminAccountCreated(
    email: string,
    name: string,
    password: string,
  ): Promise<EmailServiceResult>;
  sendEmailContactForm(
    name: string,
    email: string,
    message: string,
  ): Promise<EmailServiceResult>;
  sendEmailUserEmailChange(
    email: string,
    code: string,
    username: string,
  ): Promise<EmailServiceResult>;
}

export const EmailServiceToken = Symbol('EmailServiceToken');
