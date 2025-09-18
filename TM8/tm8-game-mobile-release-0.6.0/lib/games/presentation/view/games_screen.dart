import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8/app/widgets/tm8_bottom_sheet_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/games/presentation/logic/delete_game_cubit/delete_game_cubit.dart';
import 'package:tm8/games/presentation/logic/fetch_added_games_cubit/fetch_added_games_cubit.dart';
import 'package:tm8/games/presentation/logic/fetch_random_matchmaking_cubit/fetch_random_matchmaking_cubit.dart';
import 'package:tm8/games/presentation/widgets/tm8_added_games_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';

@RoutePage() //GamesRoute.page
class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key, required this.addedGamesCallback});

  final Function(List<String>) addedGamesCallback;

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final fetchAddedGamesCubit = sl<FetchAddedGamesCubit>();
  final deleteGameCubit = sl<DeleteGameCubit>();
  var addedGames = <String>[];

  @override
  void initState() {
    super.initState();
    fetchAddedGamesCubit.fetchAddedGames();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => fetchAddedGamesCubit,
          ),
          BlocProvider(
            create: (context) => deleteGameCubit,
          ),
          BlocProvider(
            create: (context) =>
                sl<FetchUserProfileCubit>()..fetchUserProfile(),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<FetchAddedGamesCubit, FetchAddedGamesState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (games) {
                    final game = games.map((e) => e.game.value ?? '').toList();
                    addedGames = game;
                    widget.addedGamesCallback(addedGames);
                  },
                );
              },
            ),
            BlocListener<DeleteGameCubit, DeleteGameState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: () {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'Game removed successfully',
                        error: false,
                      ),
                    );
                    fetchAddedGamesCubit.fetchAddedGames();
                  },
                  error: (error) {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: error,
                        error: true,
                      ),
                    );
                  },
                );
              },
            ),
          ],
          child: BlocBuilder<FetchAddedGamesCubit, FetchAddedGamesState>(
            builder: (context, state) {
              return state.when(
                initial: SizedBox.new,
                loading: () {
                  return _buildLoadingAddedGames();
                },
                loaded: (games) {
                  if (games.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No games added',
                          style: heading2Regular.copyWith(
                            color: achromatic100,
                          ),
                        ),
                        h12,
                        Text(
                          'You haven’t added any games yet. To start matchmaking, first add a game and fill out your preferences.',
                          style: body1Regular.copyWith(color: achromatic200),
                          textAlign: TextAlign.center,
                        ),
                        h24,
                        Tm8MainButtonWidget(
                          onTap: () {
                            context.pushRoute(
                              AddGameRoute(
                                addedGames: addedGames,
                              ),
                            );
                          },
                          buttonColor: primaryTeal,
                          text: 'Add game',
                        ),
                      ],
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return Tm8AddedGamesWidget(
                        onTapMain: () {
                          if (sl<Tm8Storage>().regionCheck) {
                            context
                                .pushRoute(
                              RandomMatchMakingRoute(
                                game: statusMapName[games[index].game.value] ??
                                    '',
                                gameValue: games[index].game.value ?? '',
                              ),
                            )
                                .whenComplete(() {
                              sl<FetchRandomMatchmakingCubit>().cleanPage();
                            });
                          } else {
                            tm8PopUpDialogWidget(
                              context,
                              padding: 12,
                              width: 300,
                              borderRadius: 20,
                              popup: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Matchmaking issue',
                                          style: heading4Regular.copyWith(
                                            color: achromatic100,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Assets.common.x.svg(),
                                        ),
                                      ],
                                    ),
                                    h18,
                                    Text(
                                      'To matchmake, you need to set your region in the settings.',
                                      style: body1Regular.copyWith(
                                        color: achromatic200,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    h12,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Tm8MainButtonWidget(
                                          onTap: () async {
                                            Navigator.of(context).pop();
                                          },
                                          buttonColor: achromatic500,
                                          text: 'Cancel',
                                          width: 130,
                                        ),
                                        w12,
                                        Tm8MainButtonWidget(
                                          onTap: () {
                                            context.pushRoute(
                                              RegionSettingsRoute(
                                                regions: const [],
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          },
                                          buttonColor: primaryTeal,
                                          text: 'Set Region',
                                          width: 130,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        onTap: () {
                          tm8BottomSheetWidget(
                            context,
                            onTap: (value) {
                              if (value == 0) {
                                Navigator.of(context).pop();
                                context.pushRoute(
                                  EditGamesPreferencesRoute(
                                    selectedGame: games[index],
                                  ),
                                );
                              } else {
                                Navigator.of(context).pop();
                                deleteGameCubit.deleteGame(
                                  game: games[index].game.value ?? '',
                                );
                              }
                            },
                            item: ['Edit preferences', 'Remove'],
                            assetIcon: [
                              Assets.common.editMessage.svg(),
                              Assets.common.delete.svg(
                                colorFilter: ColorFilter.mode(
                                  errorColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                            colors: [achromatic100, errorColor],
                          );
                        },
                        assetImage: statusMapAsset[games[index].game.value]!,
                        assetIcon: statusMapIcon[games[index].game.value]!,
                        gameName: statusMapName[games[index].game.value]!,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return h12;
                    },
                    itemCount: games.length,
                  );
                },
                error: (error) {
                  return Tm8ErrorWidget(
                    onTapRetry: () {
                      fetchAddedGamesCubit.fetchAddedGames();
                    },
                    error: error,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Skeletonizer _buildLoadingAddedGames() {
    return Skeletonizer(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Tm8AddedGamesWidget(
            onTap: () {},
            onTapMain: () {},
            assetImage: Assets.games.apexLegendsAsset.path,
            assetIcon: Assets.games.apexLegendsIcon.path,
            gameName: 'Apex Legends',
          );
        },
        separatorBuilder: (context, index) {
          return h12;
        },
        itemCount: 4,
      ),
    );
  }

  final Map<String?, String> statusMapName = {
    'apex-legends': 'Apex Legends',
    'fortnite': 'Fortnite',
    'call-of-duty': 'Call of Duty',
    'rocket-league': 'Rocket League',
  };
  final Map<String?, String> statusMapIcon = {
    'apex-legends': Assets.games.apexLegendsIcon.path,
    'fortnite': Assets.games.fortniteIcon.path,
    'call-of-duty': Assets.games.callOfDutyIcon.path,
    'rocket-league': Assets.games.rocketLeagueIcon.path,
  };
  final Map<String?, String> statusMapAsset = {
    'apex-legends': Assets.games.apexLegendsAsset.path,
    'fortnite': Assets.games.fortniteAsset.path,
    'call-of-duty': Assets.games.callOfDutyAsset.path,
    'rocket-league': Assets.games.rocketLeagueAsset.path,
  };
}
