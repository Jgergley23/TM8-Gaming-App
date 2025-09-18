// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/epic_games/presentation/logic/epic_games_verify_cubit/epic_games_verify_cubit.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/delete_epic_games_cubit/delete_epic_games_cubit.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage() //EpicGamesSettingsRoute.page
class EpicGamesSettingsScreen extends StatefulWidget {
  const EpicGamesSettingsScreen({
    super.key,
    this.epicGamesAccountName,
  });

  final String? epicGamesAccountName;

  @override
  State<EpicGamesSettingsScreen> createState() =>
      _EpicGamesSettingsScreenState();
}

class _EpicGamesSettingsScreenState extends State<EpicGamesSettingsScreen> {
  final epicGamesVerifyCubit = sl<EpicGamesVerifyCubit>();
  final deleteEpicGamesCubit = sl<DeleteEpicGamesCubit>();

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
          BlocProvider(
            create: (context) => deleteEpicGamesCubit,
          ),
        ],
        child: Tm8BodyContainerWidget(
          child: Scaffold(
            appBar: Tm8MainAppBarScaffoldWidget(
              title: 'Epic Games account',
              leading: true,
              navigationPadding: screenPadding,
            ),
            body: MultiBlocListener(
              listeners: [
                BlocListener<EpicGamesVerifyCubit, EpicGamesVerifyState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      loading: () {
                        context.loaderOverlay.show();
                      },
                      loaded: () async {
                        await sl<FetchUserProfileCubit>().fetchUserProfile();
                        context.loaderOverlay.hide();
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          Tm8SnackBar.snackBar(
                            color: glassEffectColor,
                            text: 'Epic Games account added successfully.',
                            error: false,
                          ),
                        );
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.maybePop();
                        });
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
                BlocListener<DeleteEpicGamesCubit, DeleteEpicGamesState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      loading: () {
                        context.loaderOverlay.show();
                      },
                      loaded: () async {
                        await sl<FetchUserProfileCubit>().fetchUserProfile();
                        context.loaderOverlay.hide();
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          Tm8SnackBar.snackBar(
                            color: glassEffectColor,
                            text:
                                'Epic Games account disconnected successfully.',
                            error: false,
                          ),
                        );

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.maybePop();
                        });
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
              child: Padding(
                padding: screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    h12,
                    if (widget.epicGamesAccountName == null) ...[
                      Text(
                        'No account connected yet. Connect Steam account to get more out of TM8.',
                        style: body1Regular.copyWith(color: achromatic200),
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: achromatic600,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              widget.epicGamesAccountName!,
                              style: body1Regular.copyWith(
                                color: achromatic100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    expanded,
                    Tm8MainButtonWidget(
                      onTap: () {
                        if (widget.epicGamesAccountName == null) {
                          controller.loadRequest(
                            Uri.parse(
                              Env.epicGamesUrl,
                            ),
                          );
                          context.pushRoute(
                            EpicGamesWebViewRoute(controller: controller),
                          );
                        } else {
                          deleteEpicGamesCubit.deleteEpicAccount();
                        }
                      },
                      buttonColor: widget.epicGamesAccountName == null
                          ? primaryTeal
                          : errorColor,
                      text: widget.epicGamesAccountName == null
                          ? 'Connect Epic Games'
                          : 'Remove',
                    ),
                    h20,
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
