import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/profile/presentation/logic/upload_user_intro_cubit/upload_user_intro_cubit.dart';

@RoutePage() //AudioIntroSettingsScreen.page
class AudioIntroSettingsScreen extends StatefulWidget {
  const AudioIntroSettingsScreen({super.key, required this.audioIntro});

  final String? audioIntro;

  @override
  State<AudioIntroSettingsScreen> createState() =>
      _AudioIntroSettingsScreenState();
}

class _AudioIntroSettingsScreenState extends State<AudioIntroSettingsScreen> {
  final uploadUserIntroCubit = sl<UploadUserIntroCubit>();
  RecorderController controller = RecorderController();
  late PlayerController playController;
  late String directory;
  late String? recordPath;
  bool isRecording = false;
  bool isFinishedRecording = false;
  bool permissionCheck = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
    Future.delayed(Duration.zero, () async {
      final dir = await getTemporaryDirectory();
      directory = dir.path;
    });
    playController = PlayerController()
      ..onCompletion.listen((event) {
        setState(() {});
      });
    playController.addListener(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    playController.dispose();
    super.dispose();
  }

  Future<void> _checkPermission() async {
    permissionCheck = await controller.checkPermission();
    if (!permissionCheck) {
      await Permission.microphone.shouldShowRequestRationale;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => uploadUserIntroCubit,
      child: BlocListener<UploadUserIntroCubit, UploadUserIntroState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (audioKey) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.maybePop();
              });
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                Tm8SnackBar.snackBar(
                  color: glassEffectColor,
                  text: "Audio intro uploaded successfully",
                  error: false,
                ),
              );
            },
          );
        },
        child: Tm8BodyContainerWidget(
          child: Scaffold(
            appBar: Tm8MainAppBarScaffoldWidget(
              onActionPressed: () async {
                playController.stopPlayer();
                uploadUserIntroCubit.uploadIntro(recordPath: recordPath!);
              },
              title: 'Audio intro',
              leading: true,
              navigationPadding: const EdgeInsets.only(top: 12, left: 12),
              action: true,
              actionIcon: Assets.settings.checkmark.svg(),
              actionPadding: EdgeInsets.zero,
            ),
            body: Padding(
              padding: screenPadding,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isRecording)
                      AudioFileWaveforms(
                        backgroundColor: Colors.red,
                        margin: const EdgeInsets.only(
                          right: 15,
                        ),
                        size: const Size(250, 50),
                        // waveformType: WaveformType.long,
                        playerController: playController,
                        playerWaveStyle: PlayerWaveStyle(
                          showSeekLine: false,
                          fixedWaveColor: primaryTeal,
                          liveWaveColor: primaryTealHover,
                          spacing: 12,
                          scaleFactor: 120,
                          waveThickness: 7,
                          scrollScale: 1.5,
                        ),
                      )
                    else
                      AudioWaveforms(
                        size: const Size(320, 50),
                        recorderController: controller,
                        waveStyle: WaveStyle(
                          extendWaveform: true,
                          waveColor: primaryTeal,
                          spacing: 12,
                          waveThickness: 7,
                          showMiddleLine: false,
                        ),
                        shouldCalculateScrolledPosition: true,
                      ),
                    h10,
                    if (!isFinishedRecording) ...[
                      GestureDetector(
                        onTap: () async {
                          if (!permissionCheck) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              Tm8SnackBar.snackBar(
                                color: glassEffectColor,
                                text:
                                    "Microphone permission is required to record audio",
                                error: false,
                              ),
                            );
                            return;
                          }
                          controller.reset();
                          final dt = DateTime.now().millisecondsSinceEpoch;
                          // logic needed to stop player if it isn't stopped
                          if (isRecording == false) {
                            if (playController.playerState !=
                                PlayerState.stopped) {
                              await playController.stopPlayer();
                            }
                          }
                          isRecording
                              ? recordPath = await controller.stop()
                              : await controller.record(
                                  path: '$directory/$dt.m4a',
                                );
                          if (isRecording) {
                            if (recordPath != null) {
                              await playController.preparePlayer(
                                path: recordPath!,
                              );
                            }
                          }

                          isRecording = !isRecording;

                          setState(() {});
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryTeal,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: isRecording
                                ? Assets.common.stopAudio.svg()
                                : Assets.settings.microphone.svg(),
                          ),
                        ),
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryTeal,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Assets.common.startAudio.svg(),
                              ),
                            ),
                          ),
                          w8,
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: errorColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Assets.common.delete.svg(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    h24,
                    Text(
                      'Tap button to ${isRecording == true ? 'stop' : 'start'} recording',
                      style: body1Regular.copyWith(
                        color: achromatic200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
