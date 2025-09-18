import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/games/presentation/logic/fetch_available_games_cubit/fetch_available_games_cubit.dart';
import 'package:tm8/games/presentation/logic/select_checkbox_game_cubit/select_checkbox_game_cubit.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/games_selected_cubit/games_selected_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //AddGameRoute.page
class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key, required this.addedGames});

  final List<String> addedGames;

  @override
  State<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final fetchAvailableGamesCubit = sl<FetchAvailableGamesCubit>();
  final selectCheckboxGameCubit = sl<SelectCheckboxGameCubit>();
  final gamesSelectedCubit = sl<GamesSelectedCubit>();
  var selectedGames = <String>[];

  @override
  void initState() {
    super.initState();
    fetchAvailableGamesCubit.fetchAvailableGames(
      alreadyAddedGames: widget.addedGames,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => fetchAvailableGamesCubit,
        ),
        BlocProvider(
          create: (context) => selectCheckboxGameCubit,
        ),
        BlocProvider(
          create: (context) => gamesSelectedCubit,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<FetchAvailableGamesCubit, FetchAvailableGamesState>(
            listener: (context, state) {
              state.whenOrNull(
                loaded: (games) {
                  selectCheckboxGameCubit.selectableLen(games.length);
                },
              );
            },
          ),
          BlocListener<GamesSelectedCubit, List<String>>(
            listener: (context, state) {
              selectedGames = state;
            },
          ),
        ],
        child: Tm8BodyContainerWidget(
          child: Scaffold(
            appBar: Tm8MainAppBarScaffoldWidget(
              title: 'Add games',
              leading: true,
              navigationPadding: screenPadding,
            ),
            body: Padding(
              padding: screenPadding,
              child: Column(
                children: [
                  h12,
                  BlocBuilder<FetchAvailableGamesCubit,
                      FetchAvailableGamesState>(
                    builder: (context, state) {
                      return state.when(
                        initial: SizedBox.new,
                        loading: () {
                          return _buildLoadingAvailableGames();
                        },
                        loaded: (games) {
                          return _buildLoadedAvailableGames(games);
                        },
                        error: (error) {
                          return Tm8ErrorWidget(
                            onTapRetry: () {
                              fetchAvailableGamesCubit.fetchAvailableGames(
                                alreadyAddedGames: widget.addedGames,
                              );
                            },
                            error: error,
                          );
                        },
                      );
                    },
                  ),
                  expanded,
                  BlocBuilder<SelectCheckboxGameCubit, List<bool>>(
                    builder: (context, state) {
                      return Tm8MainButtonWidget(
                        onTap: () {
                          if (selectedGames.isNotEmpty) {
                            context
                                .pushRoute(
                              AddGamesPreferencesRoute(
                                selectedGames: selectedGames,
                              ),
                            )
                                .whenComplete(() {
                              context.router.pushAndPopUntil(
                                const HomePageRoute(),
                                predicate: (_) => false,
                              );
                            });
                          }
                        },
                        buttonColor: state.every((element) => element == false)
                            ? achromatic800
                            : primaryTeal,
                        text: 'Continue',
                        textColor: state.every((element) => element == false)
                            ? achromatic400
                            : achromatic100,
                      );
                    },
                  ),
                  h12,
                  Tm8MainButtonWidget(
                    onTap: () {
                      context.maybePop();
                    },
                    buttonColor: achromatic500,
                    text: 'Cancel',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Skeletonizer _buildLoadingAvailableGames() {
    return Skeletonizer(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: achromatic600,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.games.apexLegendsIcon.path,
                  height: 24,
                  width: 24,
                ),
                w8,
                Text(
                  'Apex Legends',
                  style: body1Regular.copyWith(color: achromatic100),
                ),
                expanded,
                SizedBox(
                  height: 16,
                  width: 16,
                  child: Checkbox(
                    onChanged: (value) {
                      if (value != null) {}
                    },
                    fillColor: const WidgetStatePropertyAll(
                      Colors.transparent,
                    ),
                    activeColor: primaryTeal,
                    value: false,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return h12;
        },
        itemCount: 4,
      ),
    );
  }

  ListView _buildLoadedAvailableGames(List<GameResponse> games) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            selectCheckboxGameCubit.changeState(index);
            gamesSelectedCubit.addRemoveGame(
              game: mapGameDisplay[games[index].display] ?? '',
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: achromatic600,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  mapGameToAsset[games[index].game] ?? '',
                  height: 24,
                  width: 24,
                ),
                w8,
                Text(
                  games[index].display,
                  style: body1Regular.copyWith(color: achromatic100),
                ),
                expanded,
                BlocBuilder<SelectCheckboxGameCubit, List<bool>>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 16,
                      width: 16,
                      child: Checkbox(
                        onChanged: (value) {
                          if (value != null) {
                            selectCheckboxGameCubit.changeState(index);
                            gamesSelectedCubit.addRemoveGame(
                              game: mapGameDisplay[games[index].display] ?? '',
                            );
                          }
                        },
                        fillColor: WidgetStatePropertyAll(
                          state[index] ? primaryTeal : Colors.transparent,
                        ),
                        activeColor: primaryTeal,
                        value: state[index],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return h12;
      },
      itemCount: games.length,
    );
  }
}

final Map<GameResponseGame, String> mapGameToAsset = {
  GameResponseGame.apexLegends: Assets.games.apexLegendsIcon.path,
  GameResponseGame.callOfDuty: Assets.games.callOfDutyIcon.path,
  GameResponseGame.fortnite: Assets.games.fortniteIcon.path,
  GameResponseGame.rocketLeague: Assets.games.rocketLeagueIcon.path,
};

final Map<String, String> mapGameDisplay = {
  'Apex Legends': 'apex-legends',
  'Call of Duty': 'call-of-duty',
  'Fortnite': 'fortnite',
  'Rocket League': 'rocket-league',
};
