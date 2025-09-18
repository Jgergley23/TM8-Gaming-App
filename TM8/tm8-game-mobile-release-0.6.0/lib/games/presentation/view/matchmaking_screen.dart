import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/app/widgets/tm8_swiping_cards_widget.dart';
import 'package:tm8/games/presentation/logic/fetch_random_matchmaking_cubit/fetch_random_matchmaking_cubit.dart';
import 'package:tm8/games/presentation/logic/matchmaking_accept_cubit/matchmaking_accept_cubit.dart';
import 'package:tm8/games/presentation/logic/start_matchmaking_cubit/start_matchmaking_cubit.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';

@RoutePage() //GamesRoute.page
class MatchMakingScreen extends StatefulWidget {
  const MatchMakingScreen({
    super.key,
    required this.game,
    required this.gameValue,
  });

  final String game;
  final String gameValue;

  @override
  State<MatchMakingScreen> createState() => _MatchMakingScreenState();
}

class _MatchMakingScreenState extends State<MatchMakingScreen> {
  final matchmakingAccept = sl<MatchmakingAcceptCubit>();

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
          BlocProvider.value(
            value: sl<StartMatchmakingCubit>()
              ..matchmakingAlgoritham(game: widget.gameValue),
          ),
          BlocProvider.value(value: sl<FetchRandomMatchmakingCubit>()),
          BlocProvider(
            create: (context) => matchmakingAccept,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<StartMatchmakingCubit, StartMatchmakingState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: () {
                    context.loaderOverlay.hide();
                    sl<FetchRandomMatchmakingCubit>().fetchPageOfMatches(
                      game: widget.gameValue,
                      page: 1,
                      limit: 10,
                    );
                  },
                );
              },
            ),
            BlocListener<MatchmakingAcceptCubit, MatchmakingAcceptState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (check, index, id) {
                    if (check.isMatch) {
                      context.pushRoute(
                        MatchRoute(
                          game: widget.game,
                          matchUserId: id,
                        ),
                      );
                    }
                  },
                );
              },
            ),
            BlocListener<FetchRandomMatchmakingCubit,
                FetchRandomMatchmakingState>(
              listener: (context, state) {
                state.whenOrNull(
                  error: (error) {
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
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              appBar: Tm8MainAppBarScaffoldWidget(
                title: widget.game,
                leading: true,
                navigationPadding: screenPadding,
              ),
              body: Padding(
                padding: screenPadding,
                child:
                    BlocBuilder<StartMatchmakingCubit, StartMatchmakingState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () {
                        return Center(
                          child: CircularProgressIndicator(
                            color: achromatic200,
                          ),
                        );
                      },
                      loaded: () {
                        return Center(
                          child: BlocBuilder<FetchRandomMatchmakingCubit,
                              FetchRandomMatchmakingState>(
                            builder: (context, state) {
                              return state.when(
                                initial: SizedBox.new,
                                loading: () {
                                  return Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          achromatic200,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                loaded: (matches) {
                                  if (matches.items.isEmpty) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'No matches',
                                          style: heading2Regular.copyWith(
                                            color: achromatic100,
                                          ),
                                        ),
                                        h12,
                                        Text(
                                          'Looks like there is nobody to match with currently. Try again later.',
                                          style: body1Regular.copyWith(
                                            color: achromatic200,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        h40,
                                      ],
                                    );
                                  }
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Tm8SwipingCardsWidget(
                                        items: matches.items,
                                        gameValue: widget.gameValue,
                                        meta: matches.meta,
                                        game: widget.game,
                                        matchmakingAccept: matchmakingAccept,
                                        showButtons: true,
                                      ),
                                    ],
                                  );
                                },
                                error: (error) {
                                  return Tm8ErrorWidget(
                                    onTapRetry: () {
                                      sl<FetchRandomMatchmakingCubit>()
                                          .fetchPageOfMatches(
                                        game: widget.gameValue,
                                        page: 1,
                                        limit: 10,
                                      );
                                    },
                                    error: error,
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                      error: (error) {
                        return Tm8ErrorWidget(
                          onTapRetry: () {
                            sl<StartMatchmakingCubit>()
                                .matchmakingAlgoritham(game: widget.gameValue);
                          },
                          error: error,
                        );
                      },
                      orElse: SizedBox.new,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
