import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';

class Tm8AudioWaveFormWidget extends StatefulWidget {
  const Tm8AudioWaveFormWidget({super.key});

  @override
  State<Tm8AudioWaveFormWidget> createState() => _Tm8AudioWaveFormWidgetState();
}

class _Tm8AudioWaveFormWidgetState extends State<Tm8AudioWaveFormWidget> {
  RecorderController controller = RecorderController();
  late PlayerController playController;
  bool isRecording = false;
  bool isFinishedRecording = false;
  bool isThrottled = false;
  late String directory;
  late String? recordPath;
  var test = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final dir = await getTemporaryDirectory();
      directory = dir.path;
    });
    _checkPermission();
    playController = PlayerController()
      ..onCompletion.listen((event) {
        setState(() {});
      });
    playController.addListener(() {});
    super.initState();
  }

  Future<void> _checkPermission() async {
    final permissionCheck = await controller.checkPermission();

    if (!permissionCheck) {
      await Permission.microphone.shouldShowRequestRationale;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isRecording && isFinishedRecording) ...[
          Text(
            formatSeconds((playController.maxDuration / 1000).ceil()),
            style: heading2Regular.copyWith(color: achromatic100),
          ),
        ],
        if (isRecording) ...[
          Center(
            child: AudioWaveforms(
              size: const Size(320, 64),
              recorderController: controller,
              waveStyle: WaveStyle(
                extendWaveform: true,
                waveColor: achromatic100,
                spacing: 12,
                waveThickness: 5,
                showMiddleLine: false,
              ),
              shouldCalculateScrolledPosition: true,
            ),
          ),
        ],
        if (!isRecording) ...[
          Center(
            child: AudioFileWaveforms(
              size: const Size(320, 64),
              playerController: playController,
              waveformData: playController.waveformData,
              playerWaveStyle: PlayerWaveStyle(
                showSeekLine: false,
                fixedWaveColor: achromatic100,
                liveWaveColor: achromatic100,
                spacing: 12,
                waveThickness: 5,
              ),
            ),
          ),
        ],
        h20,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (isThrottled) {
                      logDebug('BEING THROTTLED');
                      return;
                    }
                    isThrottled = true;
                    controller.reset();
                    final dt = DateTime.now().millisecondsSinceEpoch;
                    // logic needed to stop player if it isn't stopped
                    if (isRecording == false) {
                      if (playController.playerState != PlayerState.stopped) {
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
                    isFinishedRecording = true;
                    setState(() {});
                    Future.delayed(const Duration(milliseconds: 300), () async {
                      setState(() {
                        isThrottled = false;
                      });
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: primaryTeal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        isRecording
                            ? 'assets/common/stop_audio.svg'
                            : 'assets/common/microphone.svg',
                      ),
                    ),
                  ),
                ),
                if (isFinishedRecording) ...[
                  w8,
                  GestureDetector(
                    onTap: () async {
                      playController.playerState.isPlaying
                          ? await playController.pausePlayer()
                          : await playController.startPlayer(
                              finishMode: FinishMode.pause,
                            );
                      setState(() {});
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
                          'assets/common/delete.svg',
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            h12,
            Text(
              isRecording
                  ? 'Tap button to start recording'
                  : 'Tap button to stop recording',
              style: body1Regular.copyWith(color: achromatic200),
            ),
          ],
        ),
      ],
    );
  }

  String formatSeconds(int seconds) {
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;
    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}
