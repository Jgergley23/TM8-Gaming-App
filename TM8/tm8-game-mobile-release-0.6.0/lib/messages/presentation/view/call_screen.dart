// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:tm8/app/api/get_stream_client.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/messages/presentation/logic/audio_controller_cubit/audio_controller_cubit.dart';
import 'package:tm8/messages/presentation/logic/microphone_controller_cubit/microphone_controller_cubit.dart';
import 'package:tm8/messages/presentation/logic/sned_call_notification_cubit/send_call_notification_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //CallRoute.page
class CallScreen extends StatefulWidget {
  const CallScreen({
    super.key,
    required this.userCallId,
    required this.username,
    this.callId,
    this.photoKey,
  });

  final String userCallId;
  final String username;
  final String? callId;
  final String? photoKey;

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final microphoneControllerCubit = sl<MicrophoneControllerCubit>();
  final audioControllerCubit = sl<AudioControllerCubit>();
  final sendCallNotificationCubit = sl<SendCallNotificationCubit>();
  late Call call;
  List<RtcMediaDevice> outputDevices = <RtcMediaDevice>[];
  @override
  void initState() {
    super.initState();

    // start call
    call = clientVideo.makeCall(
      callType: StreamCallType(),
      id: widget.callId ?? sl<Tm8Storage>().userId + widget.userCallId,
    );
    getOutputDevices();
  }

  void getOutputDevices() async {
    final outputDevice = await RtcMediaDeviceNotifier.instance.audioOutputs();
    outputDevices = outputDevice.getDataOrNull() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          call.end();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => microphoneControllerCubit,
          ),
          BlocProvider(
            create: (context) => audioControllerCubit,
          ),
          BlocProvider(
            create: (context) {
              if (widget.callId == null) {
                // send notification to other user
                return sendCallNotificationCubit
                  ..sendCall(
                    body: CreateCallNotificationDto(
                      recipientId: widget.userCallId,
                      callerUsername: sl<Tm8Storage>().userName,
                      redirectScreen:
                          'CallScreen/${sl<Tm8Storage>().userId + widget.userCallId}/${sl<Tm8Storage>().userName}',
                    ),
                  );
              } else {
                return sendCallNotificationCubit;
              }
            },
          ),
        ],
        child:
            BlocListener<SendCallNotificationCubit, SendCallNotificationState>(
          listener: (context, state) {
            // so it can trigger
          },
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.only(
                  top: screenPadding.top,
                  left: screenPadding.left,
                  right: screenPadding.right,
                  bottom: Platform.isIOS ? 40 : screenPadding.bottom,
                ),
                child: StreamCallContainer(
                  call: call,
                  callConnectOptions: CallConnectOptions(
                    camera: TrackOption.disabled(),
                    microphone: TrackOption.enabled(),
                    screenShare: TrackOption.disabled(),
                  ),
                  callContentBuilder: (context, call, callState) {
                    return StreamCallContent(
                      callAppBarBuilder: (context, call, callState) {
                        return _buildAppBar(callState, call);
                      },
                      callParticipantsBuilder: (context, call, callState) {
                        return _buildCallBody();
                      },
                      callControlsBuilder: (context, call, callState) {
                        return _buildControls(call, context);
                      },
                      call: call,
                      callState: callState,
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

  Row _buildControls(Call call, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<MicrophoneControllerCubit, bool>(
          builder: (context, state) {
            return CallControlOption(
              backgroundColor: primaryTeal,
              icon: state
                  ? Assets.user.microphone.svg(width: 24, height: 24)
                  : Assets.user.microphoneMuted.svg(width: 24, height: 24),
              onPressed: () {
                microphoneControllerCubit.changeSetting(
                  enabled: !state,
                );
                call.setMicrophoneEnabled(enabled: !state);
              },
            );
          },
        ),
        BlocBuilder<AudioControllerCubit, bool>(
          builder: (context, state) {
            return CallControlOption(
              backgroundColor: primaryTeal,
              icon: state
                  ? Assets.user.callerAudioMuted.svg(width: 24, height: 24)
                  : Assets.user.callerAudio.svg(width: 24, height: 24),
              onPressed: () {
                final speaker = outputDevices
                    .where((element) => element.id == 'speaker')
                    .toList();
                final earpiece = outputDevices
                    .where((element) => element.id != 'speaker')
                    .toList();
                if (speaker.isNotEmpty) {
                  if (state) {
                    call.setAudioOutputDevice(speaker.first);
                  } else {
                    call.setAudioOutputDevice(earpiece.first);
                  }
                  audioControllerCubit.changeSetting(enabled: !state);
                } else {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    Tm8SnackBar.snackBar(
                      color: glassEffectColor,
                      text: 'No speaker detected',
                      error: false,
                    ),
                  );
                }
              },
            );
          },
        ),
        CallControlOption(
          backgroundColor: errorTextColor,
          icon: Assets.user.endCall.svg(width: 24, height: 24),
          onPressed: () async {
            call.end();
            context.maybePop();
          },
        ),
      ],
    );
  }

  Center _buildCallBody() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.photoKey == null) ...[
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: achromatic600,
              ),
              child: Center(
                child: Text(
                  widget.username[0].toUpperCase(),
                  style: heading4Bold.copyWith(
                    color: achromatic100,
                  ),
                ),
              ),
            ),
          ] else ...[
            ClipOval(
              child: Image.network(
                '${Env.stagingUrlAmazon}/${widget.photoKey}',
                height: 64,
                width: 64,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
          h8,
          Text(
            widget.username,
            style: heading4Bold.copyWith(
              color: achromatic100,
            ),
          ),
        ],
      ),
    );
  }

  CallAppBar _buildAppBar(CallState callState, Call call) {
    return CallAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        callState.status == CallStatus.connecting()
            ? 'Calling...'
            : 'Voice call',
        style: heading4Regular.copyWith(color: achromatic200),
      ),
      leading: const SizedBox(),
      actions: const [SizedBox()],
      call: call,
    );
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

extension StringExtension on String {
  bool equalsIgnoreCase(String other) => toUpperCase() == other.toUpperCase();
}
