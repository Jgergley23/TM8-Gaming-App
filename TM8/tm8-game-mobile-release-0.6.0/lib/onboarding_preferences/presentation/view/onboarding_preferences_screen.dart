import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm8/app/app_bloc/app_bloc.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_select_game_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/games_selected_cubit/games_selected_cubit.dart';

@RoutePage() //OnboardingPreferencesRoute.page
class OnboardingPreferencesScreen extends StatefulWidget {
  const OnboardingPreferencesScreen({super.key});

  @override
  State<OnboardingPreferencesScreen> createState() =>
      _OnboardingPreferencesScreenState();
}

class _OnboardingPreferencesScreenState
    extends State<OnboardingPreferencesScreen> {
  final gamesSelectedCubit = sl<GamesSelectedCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gamesSelectedCubit,
      child: Tm8BodyContainerWidget(
        child: Scaffold(
          appBar: Tm8MainAppBarScaffoldWidget(
            leading: false,
            title: 'Select your games',
            navigationPadding: screenPadding,
          ),
          body: SingleChildScrollView(
            padding: screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                h12,
                Tm8SelectGameWidget(
                  onTap: () {
                    gamesSelectedCubit.addRemoveGame(game: 'apex-legends');
                  },
                  assetImage: Assets.games.apexLegendsAsset.path,
                  assetIcon: Assets.games.apexLegendsIcon.path,
                  gameName: 'Apex Legends',
                ),
                h12,
                Tm8SelectGameWidget(
                  onTap: () {
                    gamesSelectedCubit.addRemoveGame(game: 'fortnite');
                  },
                  assetImage: Assets.games.fortniteAsset.path,
                  assetIcon: Assets.games.fortniteIcon.path,
                  gameName: 'Fortnite',
                ),
                h12,
                Tm8SelectGameWidget(
                  onTap: () {
                    gamesSelectedCubit.addRemoveGame(game: 'call-of-duty');
                  },
                  assetImage: Assets.games.callOfDutyAsset.path,
                  assetIcon: Assets.games.callOfDutyIcon.path,
                  gameName: 'Call of Duty',
                ),
                h12,
                Tm8SelectGameWidget(
                  onTap: () {
                    gamesSelectedCubit.addRemoveGame(game: 'rocket-league');
                  },
                  assetImage: Assets.games.rocketLeagueAsset.path,
                  assetIcon: Assets.games.rocketLeagueIcon.path,
                  gameName: 'Rocket League',
                ),
                h24,
                BlocBuilder<GamesSelectedCubit, List<String>>(
                  builder: (context, state) {
                    return Tm8MainButtonWidget(
                      onTap: () {
                        if (state.isNotEmpty) {
                          context.pushRoute(
                            SetOnboardingPreferencesRoute(
                              selectedGames: state,
                            ),
                          );
                        }
                      },
                      buttonColor:
                          state.isNotEmpty ? primaryTeal : achromatic600,
                      text: 'Continue',
                      textColor:
                          state.isNotEmpty ? achromatic100 : achromatic400,
                    );
                  },
                ),
                h12,
                Tm8MainButtonWidget(
                  onTap: () {
                    sl<AppBloc>().add(const AppEvent.checkStatus());
                  },
                  buttonColor: achromatic500,
                  text: 'Skip',
                ),
                h20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
