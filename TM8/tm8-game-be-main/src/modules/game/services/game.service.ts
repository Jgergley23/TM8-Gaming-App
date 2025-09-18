import { Game } from 'src/common/constants';
import { games } from 'src/common/constants/games';

import { AbstractGameService } from '../abstract/abstract.game.service';
import { apexLegendsPreferenceForm } from '../constants/apex-legends-preference-form';
import { callOfDutyPreferenceForm } from '../constants/call-of-duty-preference-form';
import { fortnitePreferenceForm } from '../constants/fortnite-preference-form';
import { rocketLeaguePreferenceForm } from '../constants/rocket-league-preference-form';
import { GamePreferenceInputResponse } from '../response/game-preference-input.response';
import { GameResponse } from '../response/game-response';

export class GameService extends AbstractGameService {
  /**
   * Returns a list of all games available in the application
   * @returns list of available games
   */
  getAllGames(): GameResponse[] {
    return games;
  }

  /**
   * Returns game preference form based on game
   * @param game - game name
   * @returns game preference input response array
   */
  getPreferenceForm(game: Game): GamePreferenceInputResponse[] {
    switch (game) {
      case Game.Fortnite:
        return fortnitePreferenceForm;
      case Game.CallOfDuty:
        return callOfDutyPreferenceForm;
      case Game.RocketLeague:
        return rocketLeaguePreferenceForm;
      case Game.ApexLegends:
        return apexLegendsPreferenceForm;
      default:
        break;
    }
  }
}
