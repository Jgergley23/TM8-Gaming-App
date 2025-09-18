import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/messages/presentation/logic/audio_controller_cubit/audio_controller_cubit.dart';
import 'package:tm8/profile/presentation/logic/download_intro_cubit/download_intro_cubit.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/profile/presentation/widgets/profile_settings_buttons_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //ProfileRoute.page
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.profileInfoCallback,
  });

  final Function(GetMeUserResponse) profileInfoCallback;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final downloadIntroCubit = sl<DownloadIntroCubit>();
  final audioControllerCubit = sl<AudioControllerCubit>();

  late AudioPlayer audioPlayer;
  Duration? duration;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: sl<FetchUserProfileCubit>()..fetchUserProfile(),
        ),
        BlocProvider(
          create: (context) => downloadIntroCubit,
        ),
        BlocProvider(
          create: (context) =>
              audioControllerCubit..changeSetting(enabled: false),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<FetchUserProfileCubit, FetchUserProfileState>(
            listener: (context, state) {
              state.whenOrNull(
                loaded: (userProfile) {
                  widget.profileInfoCallback(userProfile);
                },
              );
            },
          ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<FetchUserProfileCubit, FetchUserProfileState>(
                builder: (context, state) {
                  return state.when(
                    initial: SizedBox.new,
                    loading: () {
                      final topRoute = context.topRoute;
                      if (topRoute.name == 'SettingsRoute') {
                        return const SizedBox();
                      }
                      return _buildLoadingUserInfo();
                    },
                    loaded: (profile) {
                      return _buildLoadedProfileInfo(profile);
                    },
                    error: (error) {
                      return Tm8ErrorWidget(
                        error: error,
                        onTapRetry: () {
                          sl<FetchUserProfileCubit>().fetchUserProfile();
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Skeletonizer _buildLoadingUserInfo() {
    return Skeletonizer(
      child: Column(
        children: [
          h8,
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: achromatic600,
            ),
            child: Center(
              child: Text(
                'M',
                style: heading4Bold.copyWith(
                  color: achromatic100,
                ),
              ),
            ),
          ),
          h8,
          Text(
            'loading...',
            style: heading4Bold.copyWith(color: achromatic100),
          ),
          h12,
          Text(
            'Add description',
            style: body1Bold.copyWith(
              color: achromatic100,
            ),
          ),
          h12,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileSettingsButtonsWidget(
                asset: Assets.common.editMessage.svg(),
              ),
              w8,
              ProfileSettingsButtonsWidget(
                asset: Assets.common.startAudio.svg(),
              ),
            ],
          ),
          h24,
          Text(
            'Games added',
            style: heading3Regular.copyWith(
              color: achromatic100,
            ),
          ),
          h12,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(
                          statusMapAsset['Fortnite'] ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: gameTextShadowColor,
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          statusMapAssetIcon['Fortnite'] ?? const SizedBox(),
                          h8,
                          Text(
                            'Fortnite',
                            style: body1Bold.copyWith(
                              color: achromatic100,
                            ),
                          ),
                          h10,
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Column _buildLoadedProfileInfo(GetMeUserResponse profile) {
    return Column(
      children: [
        h8,
        if (profile.photoKey == null) ...[
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: achromatic600,
            ),
            child: Center(
              child: Text(
                profile.username[0].toUpperCase(),
                style: heading4Bold.copyWith(
                  color: achromatic100,
                ),
              ),
            ),
          ),
        ] else ...[
          ClipOval(
            child: Image.network(
              '${Env.stagingUrlAmazon}/${profile.photoKey}',
              height: 90,
              width: 90,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
        h8,
        Text(
          profile.username,
          style: heading4Bold.copyWith(color: achromatic100),
        ),
        h8,
        Text(
          profile.description ?? 'Add description',
          style: profile.description != null
              ? body1Regular.copyWith(
                  color: achromatic100,
                )
              : body1Bold.copyWith(
                  color: achromatic100,
                ),
        ),
        h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.pushRoute(
                  DescriptionSettingsRoute(
                    description: profile.description ?? '',
                  ),
                );
              },
              child: ProfileSettingsButtonsWidget(
                asset: Assets.common.editMessage.svg(),
              ),
            ),
            w8,
            BlocBuilder<AudioControllerCubit, bool>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    if (state) {
                      pauseAudio();
                    } else {
                      if (profile.audioKey != null) {
                        downloadIntroCubit.downloadIntro(
                          audioKey: profile.audioKey!,
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
          ],
        ),
        h24,
        Text(
          'My games',
          style: heading3Regular.copyWith(
            color: achromatic100,
          ),
        ),
        h12,
        if (profile.games.isEmpty) ...[
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
                  addedGames: const [],
                ),
              );
            },
            buttonColor: primaryTeal,
            text: 'Add game',
          ),
        ],
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: profile.games.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(
                        statusMapAsset[profile.games[index]] ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: gameTextShadowColor,
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        statusMapAssetIcon[profile.games[index]] ??
                            const SizedBox(),
                        h8,
                        Text(
                          profile.games[index],
                          style: body1Bold.copyWith(
                            color: achromatic100,
                          ),
                        ),
                        h10,
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
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

  final Map<String, String> statusMapAsset = {
    'Apex Legends': Assets.games.apexLegendsAsset.path,
    'Fortnite': Assets.games.fortniteAsset.path,
    'Call Of Duty': Assets.games.callOfDutyAsset.path,
    'Rocket League': Assets.games.rocketLeagueAsset.path,
  };
  final Map<String, Widget> statusMapAssetIcon = {
    'Apex Legends': Assets.games.apexLegendsIcon.image(height: 24, width: 24),
    'Fortnite': Assets.games.fortniteIcon.image(height: 24, width: 24),
    'Call Of Duty': Assets.games.callOfDutyIcon.image(height: 24, width: 24),
    'Rocket League': Assets.games.rocketLeagueIcon.image(height: 24, width: 24),
  };
}

class AudioDurationCircle extends StatefulWidget {
  const AudioDurationCircle({super.key, required this.durationInSeconds});
  final int durationInSeconds;

  @override
  State<AudioDurationCircle> createState() => _AudioDurationCircleState();
}

class _AudioDurationCircleState extends State<AudioDurationCircle> {
  late Timer _timer;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), _updateProgress);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateProgress(Timer timer) {
    setState(() {
      _progress += 100 / (widget.durationInSeconds * 1000);
      if (_progress >= 1.0) {
        _progress = 1.0;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(40, 40),
      painter: CirclePainter(progress: _progress),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;

  CirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..color = achromatic600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    double radius = min(size.width / 2, size.height / 2) - 10;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      circlePaint,
    );

    double angle = progress * 2 * pi;

    Paint progressPaint = Paint()
      ..color = achromatic300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: radius,
      ),
      -pi / 2,
      angle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
