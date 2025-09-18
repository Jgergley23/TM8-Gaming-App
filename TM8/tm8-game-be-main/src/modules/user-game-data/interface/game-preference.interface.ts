import { IGamePreferenceValue } from './game-preference-value.interface';

export interface IGamePreference {
  key: string;
  values: IGamePreferenceValue[];
  title: string;
}
