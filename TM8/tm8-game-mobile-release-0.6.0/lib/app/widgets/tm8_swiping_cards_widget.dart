import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loggy/loggy.dart';
import 'package:tcard/tcard.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/games/presentation/logic/fetch_random_matchmaking_cubit/fetch_random_matchmaking_cubit.dart';
import 'package:tm8/games/presentation/logic/matchmaking_accept_cubit/matchmaking_accept_cubit.dart';
import 'package:tm8/games/presentation/logic/matchmaking_reject_cubit/matchmaking_reject_cubit.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/messages/presentation/logic/audio_controller_cubit/audio_controller_cubit.dart';
import 'package:tm8/profile/presentation/logic/download_intro_cubit/download_intro_cubit.dart';
import 'package:tm8/profile/presentation/widgets/profile_settings_buttons_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

class Tm8SwipingCardsWidget extends StatefulWidget {
  const Tm8SwipingCardsWidget({
    super.key,
    required this.items,
    required this.gameValue,
    required this.meta,
    required this.game,
    required this.matchmakingAccept,
    required this.showButtons,
  });

  final List<MatchmakingResultUserResponse> items;
  final String gameValue;
  final String game;
  final PaginationMetaResponse meta;
  final MatchmakingAcceptCubit matchmakingAccept;
  final bool showButtons;

  @override
  State<Tm8SwipingCardsWidget> createState() => _Tm8SwipingCardsWidgetState();
}

class _Tm8SwipingCardsWidgetState extends State<Tm8SwipingCardsWidget> {
  final TCardController _controller = TCardController();

  final matchmakingReject = sl<MatchmakingRejectCubit>();
  final audioControllerCubit = sl<AudioControllerCubit>();
  final downloadIntroCubit = sl<DownloadIntroCubit>();

  late AudioPlayer audioPlayer;
  Duration? duration;

  List<Widget> cards = [];

  final now = DateTime.now();

  @override
  void initState() {
    super.initState();
    cards = List.generate(
      widget.items.length,
      (index) => _buildSwipedCard(match: widget.items[index]),
    );
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        audioControllerCubit.changeSetting(enabled: false);
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playAudio(Source source) async {
    await audioPlayer.setVolume(1);
    await audioPlayer.play(source);
    duration = await audioPlayer.getDuration();
    audioControllerCubit.changeSetting(enabled: true);
  }

  void pauseAudio() async {
    await audioPlayer.pause();

    audioControllerCubit.changeSetting(enabled: false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => matchmakingReject,
        ),
        BlocProvider(
          create: (context) =>
              audioControllerCubit..changeSetting(enabled: false),
        ),
        BlocProvider(
          create: (context) => downloadIntroCubit,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<DownloadIntroCubit, DownloadIntroState>(
            listener: (context, state) {
              state.whenOrNull(
                loaded: (source) {
                  playAudio(source);
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
        child: Column(
          children: [
            TCard(
              onForward: (index, info) {
                logInfo(info.direction);
                final index = _controller.index - 1;
                if (index == widget.items.length - 1) {
                  if (info.direction == SwipDirection.Left) {
                    matchmakingReject.matchmakingReject(
                      game: widget.gameValue,
                      body: GetUserByIdParams(
                        userId: widget.items[index].id,
                      ),
                    );
                  } else if (info.direction == SwipDirection.Right) {
                    widget.matchmakingAccept.matchmakingAccept(
                      game: widget.gameValue,
                      body: GetUserByIdParams(
                        userId: widget.items[index].id,
                      ),
                      index: index,
                    );
                  }

                  sl<FetchRandomMatchmakingCubit>().fetchPageOfMatches(
                    game: widget.gameValue,
                    page: (widget.meta.page + 1).toInt(),
                    limit: 10,
                  );
                } else {
                  if (info.direction == SwipDirection.Left) {
                    matchmakingReject.matchmakingReject(
                      game: widget.gameValue,
                      body: GetUserByIdParams(
                        userId: widget.items[index].id,
                      ),
                    );
                  } else if (info.direction == SwipDirection.Right) {
                    widget.matchmakingAccept.matchmakingAccept(
                      game: widget.gameValue,
                      body: GetUserByIdParams(
                        userId: widget.items[index].id,
                      ),
                      index: index,
                    );
                  }
                }
              },
              cards: cards,
              controller: _controller,
              size: Size(
                380,
                widget.game == 'Apex Legends'
                    ? 560
                    : widget.game == 'Call of Duty'
                        ? 540
                        : 480,
              ),
            ),
            h24,
            if (widget.showButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.forward(direction: SwipDirection.Left);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: errorColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/common/x.svg',
                        ),
                      ),
                    ),
                  ),
                  w8,
                  GestureDetector(
                    onTap: () {
                      _controller.forward(direction: SwipDirection.Right);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/common/check.svg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Container _buildSwipedCard({
    required MatchmakingResultUserResponse match,
  }) {
    final preferences =
        match.preferences.where((element) => element.key != 'online-schedule');
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: achromatic700,
        boxShadow: [
          overlayShadow,
        ],
      ),
      child: Column(
        children: [
          if (match.photoKey == null) ...[
            Container(
              height: 82,
              width: 82,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: achromatic600,
              ),
              child: Center(
                child: Text(
                  match.username[0].toUpperCase(),
                  style: heading4Bold.copyWith(
                    color: achromatic100,
                  ),
                ),
              ),
            ),
          ] else ...[
            ClipOval(
              child: Image.network(
                '${Env.stagingUrlAmazon}/${match.photoKey}',
                height: 82,
                width: 82,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
          h12,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              w12,
              _buildUserInfo(match: match),
              const Spacer(),
              BlocBuilder<AudioControllerCubit, bool>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      if (state) {
                        pauseAudio();
                      } else {
                        if (match.audioKey != null) {
                          downloadIntroCubit.downloadIntro(
                            audioKey: match.audioKey!,
                          );
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            Tm8SnackBar.snackBar(
                              color: glassEffectColor,
                              text: 'No intro audio to play.',
                              error: false,
                            ),
                          );
                        }
                      }
                    },
                    child: Stack(
                      children: [
                        ProfileSettingsButtonsWidget(
                          asset: state
                              ? Assets.common.stopAudio.svg()
                              : Assets.common.startAudio.svg(),
                        ),
                      ],
                    ),
                  );
                },
              ),
              w4,
            ],
          ),
          h12,
          cardDivider,
          h12,
          for (var item in preferences) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.title,
                style: captionRegular.copyWith(
                  color: achromatic200,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
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
                          style: body2Regular.copyWith(color: achromatic100),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
            w12,
          ],
        ],
      ),
    );
  }

  Column _buildUserInfo({
    required MatchmakingResultUserResponse match,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          match.username,
          style: heading4Bold.copyWith(color: achromatic100),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Age: ${(now.difference(match.dateOfBirth).inDays / 365).toStringAsFixed(0)}',
              style: body2Regular.copyWith(color: achromatic100),
            ),
            w8,
            Container(
              height: 3,
              width: 3,
              decoration: BoxDecoration(
                color: achromatic200,
              ),
            ),
            w8,
            Text(
              'Country: ${match.country}',
              style: body2Regular.copyWith(color: achromatic100),
            ),
          ],
        ),
      ],
    );
  }
}
