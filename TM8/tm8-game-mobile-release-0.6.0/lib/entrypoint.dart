import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:tm8/app/api/get_stream_client.dart';
import 'package:tm8/app/app_bloc/app_bloc.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/friends/presentation/logic/fetch_friends_cubit/fetch_friends_cubit.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';

@RoutePage()
class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({super.key});

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AppBloc>()..add(const AppEvent.checkStatus()),
        ),
        BlocProvider(
          create: (context) => sl<FetchChannelsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<FetchFriendsCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              state.when(
                authenticated: () {
                  context.router.pushAndPopUntil(
                    const HomePageRoute(),
                    predicate: (_) => false,
                  );
                },
                unauthenticated: (message) {
                  if (message != null) {
                    logInfo(message);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        Tm8SnackBar.snackBar(
                          color: glassEffectColor,
                          text: message,
                          error: false,
                        ),
                      );
                    });
                  }
                  context.router.pushAndPopUntil(
                    const LoginRoute(),
                    predicate: (_) => false,
                  );
                },
              );
            },
            child: AutoRouter(
              // navigatorObservers: () => [],
              // placeholder: routerPlaceholder,

              builder: (context, child) => StreamChat(
                onBackgroundEventReceived: (event) {
                  logInfo(event);
                },
                client: client,
                streamChatThemeData: StreamChatThemeData(
                  colorTheme: StreamColorTheme.dark(
                    overlay: Colors.transparent,
                    appBg: achromatic700,
                    barsBg: primaryTeal,
                    overlayDark: Colors.transparent,
                  ),
                  messageInputTheme: StreamMessageInputThemeData(
                    inputBackgroundColor: achromatic700,
                  ),
                ),
                useMaterial3: true,
                child: Builder(
                  builder: (_) {
                    return child;
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
