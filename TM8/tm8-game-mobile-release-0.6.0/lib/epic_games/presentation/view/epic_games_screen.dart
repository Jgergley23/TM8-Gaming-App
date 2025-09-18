import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/epic_games/presentation/logic/epic_games_verify_cubit/epic_games_verify_cubit.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage() //EpicGamesRoute.page
class EpicGamesScreen extends StatefulWidget {
  const EpicGamesScreen({super.key});

  @override
  State<EpicGamesScreen> createState() => _EpicGamesScreenState();
}

class _EpicGamesScreenState extends State<EpicGamesScreen> {
  final epicGamesVerifyCubit = sl<EpicGamesVerifyCubit>();

  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent('http.agent')
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('callback?code')) {
              Uri uri = Uri.parse(request.url);
              String? code = uri.queryParameters['code'];
              epicGamesVerifyCubit.epicGamesVerify(
                body: EpicGamesVerifyInput(
                  code: code ?? '',
                  userId: sl<Tm8Storage>().userId,
                ),
              );
              Navigator.of(context).pop();
              context.loaderOverlay.hide();
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );
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
            create: (context) => epicGamesVerifyCubit,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<EpicGamesVerifyCubit, EpicGamesVerifyState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: () {
                    context.loaderOverlay.hide();
                    context.pushRoute(const OnboardingPreferencesRoute());
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
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              body: _buildConnectEpicGames(context),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildConnectEpicGames(BuildContext context) {
    return Padding(
      padding: screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          expanded,
          Text(
            'Connect Epic Games',
            style: heading2Regular.copyWith(color: achromatic100),
          ),
          h12,
          Text(
            'Connect your Epic Games account to pull all your awesome stats. Ths will help find the best matches for you. ',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
            textAlign: TextAlign.center,
          ),
          h24,
          Tm8MainButtonWidget(
            onTap: () {
              controller.loadRequest(
                Uri.parse(
                  Env.epicGamesUrl,
                ),
              );
              context.pushRoute(
                EpicGamesWebViewRoute(controller: controller),
              );
            },
            buttonColor: primaryTeal,
            text: 'Connect Epic Games',
          ),
          h12,
          Tm8MainButtonWidget(
            onTap: () {
              context.pushRoute(const OnboardingPreferencesRoute());
            },
            buttonColor: achromatic500,
            text: "I'll do this later",
          ),
          expanded,
        ],
      ),
    );
  }
}
