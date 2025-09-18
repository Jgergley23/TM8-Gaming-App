import 'package:flutter/widgets.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_container_widget.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';
import 'package:tm8_game_admin/user_details/presentation/widgets/game_details_widget.dart';

class GameContainerWidget extends StatelessWidget {
  const GameContainerWidget({super.key, required this.gameData});

  final UserGameDataResponse gameData;

  @override
  Widget build(BuildContext context) {
    return Tm8MainContainerWidget(
      width: MediaQuery.of(context).size.width * 0.38,
      padding: 16,
      borderRadius: 20,
      constraints: const BoxConstraints(minHeight: 180),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                userGameDataAsset[gameData.game].toString(),
                height: 24,
                width: 24,
              ),
              w6,
              Text(
                userGameData[gameData.game].toString(),
                style: heading4Regular.copyWith(
                  color: achromatic100,
                ),
              ),
            ],
          ),
          h12,
          Wrap(
            runSpacing: 12,
            children: gameData.preferences.map((game) {
              return GameDetailsWidget(
                category: game.title,
                value: game.values
                    .map(
                      (e) => e.selectedValue != null
                          ? e.selectedValue.toString()
                          : e.numericDisplay ?? '-',
                    )
                    .join(', '),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

final Map<UserGameDataResponseGame, String> userGameData = {
  UserGameDataResponseGame.callOfDuty: 'Call of Duty',
  UserGameDataResponseGame.fortnite: 'Fortnite',
  UserGameDataResponseGame.rocketLeague: 'Rocket League',
  UserGameDataResponseGame.apexLegends: 'Apex Legends',
};

final Map<UserGameDataResponseGame, String> userGameDataAsset = {
  UserGameDataResponseGame.callOfDuty: 'assets/games/call_of_duty_icon.png',
  UserGameDataResponseGame.fortnite: 'assets/games/fortnite_icon.png',
  UserGameDataResponseGame.rocketLeague: 'assets/games/rocket_league_icon.png',
  UserGameDataResponseGame.apexLegends: 'assets/games/apex_legends_icon.png',
};
