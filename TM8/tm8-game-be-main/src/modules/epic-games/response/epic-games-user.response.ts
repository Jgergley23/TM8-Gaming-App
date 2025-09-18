export class LinkedAccountResponse {
  identityProviderId: string;
  displayName: string;
}

export class EpicGamesUserResponse {
  accountId: string;
  displayName: string;
  prefferedLanguage: string;
  linkedAccouns: LinkedAccountResponse[];
  country?: string;
}
