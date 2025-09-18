import { Game } from 'src/common/constants';
import { GameResponse } from 'src/modules/game/response/game-response';

export const games: GameResponse[] = [
  {
    display: 'Apex Legends',
    game: Game.ApexLegends,
    iconKey: '/game-icons/apex_legends_icon.png',
  },
  {
    display: 'Call of Duty',
    game: Game.CallOfDuty,
    iconKey: '/game-icons/call_of_duty_icon.png',
  },
  {
    display: 'Fortnite',
    game: Game.Fortnite,
    iconKey: '/game-icons/fortnite_icon.png',
  },
  {
    display: 'Rocket League',
    game: Game.RocketLeague,
    iconKey: '/game-icons/rocket_league_icon.png',
  },
];
