import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_drop_down_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/games/presentation/logic/accept_random_match_cubit/accepted_random_match_cubit.dart';
import 'package:tm8/games/presentation/logic/fetch_random_matchmaking_cubit/fetch_random_matchmaking_cubit.dart';
import 'package:tm8/games/presentation/logic/game_time_set_cubit/game_time_set_cubit.dart';
import 'package:tm8/games/presentation/logic/matchmaking_accept_cubit/matchmaking_accept_cubit.dart';
import 'package:tm8/games/presentation/logic/matchmaking_online_schedule_cubit/matchmaking_online_schedule_cubit.dart';
import 'package:tm8/games/presentation/logic/matchmaking_schedule_remove_cubit/matchmaking_schedule_remove_cubit.dart';
import 'package:tm8/games/presentation/logic/rebuild_online_scheduler_cubit/rebuild_online_scheduler_cubit.dart';
import 'package:tm8/games/presentation/logic/start_matchmaking_cubit/start_matchmaking_cubit.dart';
import 'package:tm8/games/presentation/widgets/tm8_online_schedule_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //RandomMatchMakingScreen.page
class RandomMatchMakingScreen extends StatefulWidget {
  const RandomMatchMakingScreen({
    super.key,
    required this.game,
    required this.gameValue,
  });

  final String game;
  final String gameValue;

  @override
  State<RandomMatchMakingScreen> createState() =>
      _RandomMatchMakingScreenState();
}

class _RandomMatchMakingScreenState extends State<RandomMatchMakingScreen> {
  final unfocusDropDownCubit = sl<UnfocusDropDownCubit>();
  final gameTimeSetCubit = sl<GameTimeSetCubit>();
  final matchmakingAccept = sl<MatchmakingAcceptCubit>();
  final acceptedRandomMatchCubit = sl<AcceptedRandomMatchCubit>();
  final matchmakingOnlineScheduleCubit = sl<MatchmakingOnlineScheduleCubit>();
  final matchmakingScheduleRemoveCubit = sl<MatchmakingScheduleRemoveCubit>();
  final rebuildOnlineSchedulerCubit = sl<RebuildOnlineSchedulerCubit>();

  String playTimeValue = '';
  String playTime = '';
  DateTime now = DateTime.now();
  final formKey = GlobalKey<FormBuilderState>();
  double width = 0;

  @override
  void initState() {
    super.initState();
    // start the algorithm with selected time before, or 15 min if not selected
    playTime = _checkGameTime();

    if (playTime == '') {
      playTimeValue = '30 Minutes';
      gameTimeSetCubit.setGameTime(
        game: widget.gameValue,
        body: const SetGamePlaytimeInput(playtime: '30-minutes'),
      );
      // startMatchMakingCubit.matchmakingAlgoritham(
      //   game: widget.gameValue,
      // );
      playTime = playTimeValue;
    } else {
      // playTimeValue = statusMapPlayTimeValue[playTime]!;
      // gameTimeSetCubit.setGameTime(
      //   game: widget.gameValue,
      //   body: SetGamePlaytimeInput(playtime: playTimeValue),
      // );
    }
    //check if date schedule is expired
    final dateTo = _checkGameDateTo();

    if (dateTo != '') {
      final dateToDateTime = DateTime.parse(dateTo);
      if (now.isAfter(dateToDateTime)) {
        _removeGameDateStorage();
        matchmakingScheduleRemoveCubit.removeOnlineSchedule(
          game: widget.gameValue,
          refetch: true,
        );
      }
    }
  }

  _checkGameDateTo() {
    if (widget.game == 'Fortnite') {
      return sl<Tm8Storage>().toOnlineMatchMakingTimeFortnite;
    } else if (widget.game == 'Call of Duty') {
      return sl<Tm8Storage>().toOnlineMatchMakingTimeCallOfDuty;
    } else if (widget.game == 'Rocket League') {
      return sl<Tm8Storage>().toOnlineMatchMakingTimeRocketLeague;
    } else {
      return sl<Tm8Storage>().toOnlineMatchMakingTimeApex;
    }
  }

  _checkGameDateFrom() {
    if (widget.game == 'Fortnite') {
      return sl<Tm8Storage>().fromOnlineMatchMakingTimeFortnite;
    } else if (widget.game == 'Call of Duty') {
      return sl<Tm8Storage>().fromOnlineMatchMakingTimeCallOfDuty;
    } else if (widget.game == 'Rocket League') {
      return sl<Tm8Storage>().fromOnlineMatchMakingTimeRocketLeague;
    } else {
      return sl<Tm8Storage>().fromOnlineMatchMakingTimeApex;
    }
  }

  _removeGameDateStorage() {
    if (widget.game == 'Fortnite') {
      sl<Tm8Storage>().fromOnlineMatchMakingTimeFortnite = '';
      sl<Tm8Storage>().toOnlineMatchMakingTimeFortnite = '';
    } else if (widget.game == 'Call of Duty') {
      sl<Tm8Storage>().fromOnlineMatchMakingTimeCallOfDuty = '';
      sl<Tm8Storage>().toOnlineMatchMakingTimeCallOfDuty = '';
    } else if (widget.game == 'Rocket League') {
      sl<Tm8Storage>().fromOnlineMatchMakingTimeRocketLeague = '';
      sl<Tm8Storage>().toOnlineMatchMakingTimeRocketLeague = '';
    } else {
      sl<Tm8Storage>().fromOnlineMatchMakingTimeApex = '';
      sl<Tm8Storage>().toOnlineMatchMakingTimeApex = '';
    }
  }

  _storeGameDateStorage(String dateTo, String dateFrom) {
    if (widget.game == 'Fortnite') {
      sl<Tm8Storage>().fromOnlineMatchMakingTimeFortnite = dateFrom;
      sl<Tm8Storage>().toOnlineMatchMakingTimeFortnite = dateTo;
    } else if (widget.game == 'Call of Duty') {
      sl<Tm8Storage>().fromOnlineMatchMakingTimeCallOfDuty = dateFrom;
      sl<Tm8Storage>().toOnlineMatchMakingTimeCallOfDuty = dateTo;
    } else if (widget.game == 'Rocket League') {
      sl<Tm8Storage>().fromOnlineMatchMakingTimeRocketLeague = dateFrom;
      sl<Tm8Storage>().toOnlineMatchMakingTimeRocketLeague = dateTo;
    } else {
      sl<Tm8Storage>().fromOnlineMatchMakingTimeApex = dateFrom;
      sl<Tm8Storage>().toOnlineMatchMakingTimeApex = dateTo;
    }
  }

  _checkGameTime() {
    if (widget.game == 'Fortnite') {
      return sl<Tm8Storage>().storedMatchmakingTimeFortnite;
    } else if (widget.game == 'Call of Duty') {
      return sl<Tm8Storage>().storedMatchmakingTimeCallOfDuty;
    } else if (widget.game == 'Rocket League') {
      return sl<Tm8Storage>().storedMatchmakingTimeRocketLeague;
    } else {
      return sl<Tm8Storage>().storedMatchmakingTimeApex;
    }
  }

  _updateGameTime(String time) {
    if (widget.game == 'Fortnite') {
      sl<Tm8Storage>().storedMatchmakingTimeFortnite = time;
    } else if (widget.game == 'Call of Duty') {
      sl<Tm8Storage>().storedMatchmakingTimeCallOfDuty = time;
    } else if (widget.game == 'Rocket League') {
      sl<Tm8Storage>().storedMatchmakingTimeRocketLeague = time;
    } else {
      sl<Tm8Storage>().storedMatchmakingTimeApex = time;
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Portal(
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return Tm8LoadingOverlayWidget(progress: progress);
        },
        overlayColor: Colors.transparent,
        child: MultiBlocProvider(
          providers: [
            if (_checkGameTime() != '')
              BlocProvider.value(
                value: sl<FetchRandomMatchmakingCubit>()
                  ..fetchRandomMatchmaking(game: widget.gameValue),
              )
            else
              BlocProvider.value(
                value: sl<FetchRandomMatchmakingCubit>(),
              ),
            BlocProvider(
              create: (context) => unfocusDropDownCubit,
            ),
            BlocProvider(
              create: (context) => gameTimeSetCubit,
            ),
            BlocProvider(
              create: (context) => matchmakingAccept,
            ),
            BlocProvider.value(
              value: sl<StartMatchmakingCubit>(),
            ),
            BlocProvider(
              create: (context) => acceptedRandomMatchCubit,
            ),
            BlocProvider(
              create: (context) => matchmakingOnlineScheduleCubit,
            ),
            BlocProvider(
              create: (context) => matchmakingScheduleRemoveCubit,
            ),
            BlocProvider(
              create: (context) => rebuildOnlineSchedulerCubit,
            ),
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener<GameTimeSetCubit, GameTimeSetState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loading: () {
                      context.loaderOverlay.show();
                    },
                    loaded: () {
                      sl<StartMatchmakingCubit>().matchmakingAlgoritham(
                        game: widget.gameValue,
                      );
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
              BlocListener<StartMatchmakingCubit, StartMatchmakingState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loaded: () {
                      sl<FetchRandomMatchmakingCubit>().fetchRandomMatchmaking(
                        game: widget.gameValue,
                      );
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
              BlocListener<MatchmakingAcceptCubit, MatchmakingAcceptState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loaded: (accepted, index, id) {
                      acceptedRandomMatchCubit.changeState(index);
                      if (accepted.isMatch) {
                        context.pushRoute(
                          MatchRoute(
                            game: widget.game,
                            matchUserId: id,
                          ),
                        );
                      }
                    },
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
              BlocListener<FetchRandomMatchmakingCubit,
                  FetchRandomMatchmakingState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loaded: (matches) {
                      context.loaderOverlay.hide();
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
              BlocListener<MatchmakingOnlineScheduleCubit,
                  MatchmakingOnlineScheduleState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loading: () {
                      context.loaderOverlay.show();
                    },
                    loaded: () {
                      sl<StartMatchmakingCubit>().matchmakingAlgoritham(
                        game: widget.gameValue,
                      );
                    },
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
              BlocListener<MatchmakingScheduleRemoveCubit,
                  MatchmakingScheduleRemoveState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loading: () {
                      context.loaderOverlay.show();
                    },
                    loaded: (refetch) {
                      sl<StartMatchmakingCubit>().matchmakingAlgoritham(
                        game: widget.gameValue,
                      );
                    },
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
              child: GestureDetector(
                onTap: () {
                  unfocusDropDownCubit.unfocus();
                },
                child: Scaffold(
                  appBar: Tm8MainAppBarScaffoldWidget(
                    title: widget.game,
                    leading: true,
                    navigationPadding: screenPadding,
                  ),
                  body: FormBuilder(
                    key: formKey,
                    child: SingleChildScrollView(
                      padding: screenPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Online Schedule',
                                      style: heading4Regular.copyWith(
                                        color: achromatic100,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' (optional)',
                                      style: heading4Regular.copyWith(
                                        color: achromatic200,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_checkGameDateTo() != '' &&
                                      _checkGameDateFrom() != '') {
                                    _removeGameDateStorage();
                                    matchmakingScheduleRemoveCubit
                                        .removeOnlineSchedule(
                                      game: widget.gameValue,
                                      refetch: true,
                                    );
                                    rebuildOnlineSchedulerCubit.rebuild();
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.refresh,
                                      color: achromatic200,
                                    ),
                                    Text(
                                      'Reset',
                                      style: heading4Regular.copyWith(
                                        color: achromatic200,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          h12,
                          BlocBuilder<RebuildOnlineSchedulerCubit, bool>(
                            builder: (context, state) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Tm8OnlineScheduleWidget(
                                      onDateSelected: (date) {
                                        final state = formKey.currentState!;
                                        if (state.saveAndValidate()) {
                                          final dateFrom =
                                              state.fields['date_from']!.value;
                                          final dateTo =
                                              state.fields['date_to']!.value;
                                          if (dateFrom != null &&
                                              dateTo != null) {
                                            final dateFromDate = DateTime.parse(
                                              dateFrom.toString(),
                                            );
                                            final dateToDate = DateTime.parse(
                                              dateTo.toString(),
                                            );
                                            if (dateFromDate
                                                    .isBefore(dateToDate) ||
                                                dateFromDate != dateToDate) {
                                              _storeGameDateStorage(
                                                dateTo.toString(),
                                                dateFrom.toString(),
                                              );
                                              matchmakingOnlineScheduleCubit
                                                  .onlineSchedule(
                                                body: SetOnlineScheduleInput(
                                                  startingTimestamp:
                                                      dateFromDate,
                                                  endingTimestamp: dateToDate,
                                                ),
                                                game: widget.gameValue,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                Tm8SnackBar.snackBar(
                                                  color: glassEffectColor,
                                                  text:
                                                      'Date From must be before date To.',
                                                  error: false,
                                                ),
                                              );
                                            }
                                          }
                                        }
                                      },
                                      name: 'date_from',
                                      hintText: 'Date from',
                                      date: _checkGameDateFrom() != ''
                                          ? DateTime.parse(
                                              _checkGameDateFrom(),
                                            )
                                          : null,
                                      mode: CupertinoDatePickerMode.dateAndTime,
                                      maximumDate: DateTime(
                                        now.year,
                                        now.month + 1,
                                        now.day,
                                      ),
                                    ),
                                  ),
                                  w10,
                                  Expanded(
                                    child: Tm8OnlineScheduleWidget(
                                      onDateSelected: (date) {
                                        final state = formKey.currentState!;
                                        if (state.saveAndValidate()) {
                                          final dateFrom =
                                              state.fields['date_from']!.value;
                                          final dateTo =
                                              state.fields['date_to']!.value;
                                          if (dateFrom != null &&
                                              dateTo != null) {
                                            final dateFromDate = DateTime.parse(
                                              dateFrom.toString(),
                                            );
                                            final dateToDate = DateTime.parse(
                                              dateTo.toString(),
                                            );
                                            if (dateFromDate
                                                    .isBefore(dateToDate) ||
                                                dateFromDate != dateToDate) {
                                              _storeGameDateStorage(
                                                dateTo.toString(),
                                                dateFrom.toString(),
                                              );
                                              matchmakingOnlineScheduleCubit
                                                  .onlineSchedule(
                                                body: SetOnlineScheduleInput(
                                                  startingTimestamp:
                                                      dateFromDate,
                                                  endingTimestamp: dateToDate,
                                                ),
                                                game: widget.gameValue,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                Tm8SnackBar.snackBar(
                                                  color: glassEffectColor,
                                                  text:
                                                      'Date From must be before date To.',
                                                  error: false,
                                                ),
                                              );
                                            }
                                          }
                                        }
                                      },
                                      name: 'date_to',
                                      hintText: 'Date to',
                                      date: _checkGameDateTo() != ''
                                          ? DateTime.parse(
                                              _checkGameDateTo(),
                                            )
                                          : null,
                                      mode: CupertinoDatePickerMode.dateAndTime,
                                      maximumDate: DateTime(
                                        now.year,
                                        now.month + 1,
                                        now.day,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          h12,
                          const Text('Playable Time', style: heading4Regular),
                          h12,
                          Tm8DropDownWidget(
                            categories: const [
                              '15 Minutes',
                              '30 Minutes',
                              '1 Hour',
                              '2 Hours',
                              '3 Hours',
                              'more then 5 hours',
                            ],
                            dropDownSelection: (value) {
                              playTimeValue = statusMapPlayTimeValue[value]!;

                              _updateGameTime(value);
                              gameTimeSetCubit.setGameTime(
                                game: widget.gameValue,
                                body: SetGamePlaytimeInput(
                                  playtime: playTimeValue,
                                ),
                              );
                            },
                            followerAlignment: Alignment.topCenter,
                            selectedItem: playTime,
                            hintText: '',
                          ),
                          h12,
                          BlocBuilder<FetchRandomMatchmakingCubit,
                              FetchRandomMatchmakingState>(
                            builder: (context, state) {
                              return state.when(
                                initial: SizedBox.new,
                                loading: () {
                                  return _buildLoadingMatches();
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
                                  return _buildLoadedMatches(matches);
                                },
                                error: (error) {
                                  return Tm8ErrorWidget(
                                    onTapRetry: () {
                                      sl<FetchRandomMatchmakingCubit>()
                                          .fetchRandomMatchmaking(
                                        game: widget.gameValue,
                                      );
                                    },
                                    error: error,
                                  );
                                },
                              );
                            },
                          ),
                          h12,
                          GestureDetector(
                            onTap: () {
                              sl<FetchRandomMatchmakingCubit>().cleanPage();
                              context
                                  .pushRoute(
                                MatchMakingRoute(
                                  game: widget.game,
                                  gameValue: widget.gameValue,
                                ),
                              )
                                  .whenComplete(() {
                                sl<FetchRandomMatchmakingCubit>()
                                    .fetchRandomMatchmaking(
                                  game: widget.gameValue,
                                );
                              });
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: primaryTeal,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Matchmake',
                                      style: body1Regular.copyWith(
                                        color: achromatic100,
                                      ),
                                    ),
                                    w12,
                                    Assets.common.matchmake.svg(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          h20,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center _buildLoadingMatches() {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(achromatic200),
        ),
      ),
    );
  }

  Column _buildLoadedMatches(MatchmakingResultPaginatedResponse matches) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildListItem(matches, index);
          },
          separatorBuilder: (context, index) {
            return h12;
          },
          itemCount: matches.items.length,
        ),
        h12,
      ],
    );
  }

  Container _buildListItem(
    MatchmakingResultPaginatedResponse matches,
    int index,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: achromatic700,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (matches.items[index].photoKey == null) ...[
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: achromatic600,
                      ),
                      child: Center(
                        child: Text(
                          matches.items[index].username[0].toUpperCase(),
                          style: heading4Bold.copyWith(
                            color: achromatic100,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    ClipOval(
                      child: Image.network(
                        '${Env.stagingUrlAmazon}/${matches.items[index].photoKey}',
                        height: 32,
                        width: 32,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                  w12,
                  Text(
                    matches.items[index].username,
                    style: body1Regular.copyWith(
                      color: achromatic100,
                    ),
                  ),
                ],
              ),
              BlocBuilder<AcceptedRandomMatchCubit, List<bool>>(
                builder: (context, state) {
                  if (index >= state.length) {
                    return const SizedBox();
                  }
                  if (state[index]) {
                    return Assets.common.matchmakeAccept.svg();
                  } else {
                    return GestureDetector(
                      onTap: () {
                        matchmakingAccept.matchmakingAccept(
                          game: widget.gameValue,
                          body: GetUserByIdParams(
                            userId: matches.items[index].id,
                          ),
                          index: index,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          color: achromatic500,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Assets.common.plus.svg(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          h12,
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 12,
            children: [
              for (var item in matches.items[index].preferences.take(3)) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: captionRegular.copyWith(
                        color: achromatic200,
                      ),
                    ),
                    Wrap(
                      children: item.values.map((value) {
                        return Wrap(
                          children: [
                            Text(
                              value.selectedValue != null
                                  ? value.selectedValue!
                                  : value.numericDisplay != null
                                      ? value.numericDisplay!
                                      : 'No value available',
                              style: body2Regular.copyWith(
                                color: achromatic100,
                              ),
                            ),
                            if (value != item.values.last)
                              Text(
                                ', ',
                                style:
                                    body2Regular.copyWith(color: achromatic100),
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
                w12,
              ],
            ],
          ),
        ],
      ),
    );
  }
}

final Map<String, String> statusMapPlayTimeValue = {
  '15 Minutes': '15-minutes',
  '30 Minutes': '30-minutes',
  '1 Hour': '1-hour',
  '2 Hours': '2-hours',
  '3 Hours': '3-hours',
  'more then 5 hours': 'more-than-5-hours',
};
