import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/app_bloc/app_bloc.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/profile/presentation/widgets/settings_item_widget.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage() //SettingsRoute.page
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<FetchUserProfileCubit>()..fetchUserProfile(),
      child: Tm8BodyContainerWidget(
        child: Scaffold(
          appBar: Tm8MainAppBarScaffoldWidget(
            title: 'Settings',
            leading: true,
            navigationPadding: screenPadding,
          ),
          body: SingleChildScrollView(
            padding: screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                h12,
                BlocBuilder<FetchUserProfileCubit, FetchUserProfileState>(
                  builder: (context, state) {
                    return state.when(
                      initial: SizedBox.new,
                      loading: () {
                        return Skeletonizer(
                          child: Column(
                            children: [
                              SettingsItemWidget(
                                onTap: () {},
                                itemName: 'Profile Settings',
                                itemAssetIcon:
                                    Assets.settings.profileSettings.svg(),
                              ),
                              h12,
                              SettingsItemWidget(
                                onTap: () {},
                                itemName: 'Notifications',
                                itemAssetIcon:
                                    Assets.settings.notifications.svg(),
                              ),
                              h12,
                              SettingsItemWidget(
                                onTap: () {},
                                itemName: 'Languages',
                                itemAssetIcon: Assets.settings.languages.svg(),
                              ),
                              // h12,
                              // SettingsItemWidget(
                              //   onTap: () {},
                              //   itemName: 'Epic Games account',
                              //   itemAssetIcon: Assets.settings.epicGames.svg(),
                              // ),
                              h12,
                              SettingsItemWidget(
                                onTap: () {},
                                itemName: 'Region',
                                itemAssetIcon: Assets.settings.region.svg(),
                              ),
                              h12,
                              SettingsItemWidget(
                                onTap: () {},
                                itemName: 'Blocked users',
                                itemAssetIcon:
                                    Assets.settings.blockedUsers.svg(),
                              ),
                            ],
                          ),
                        );
                      },
                      loaded: (userInfo) {
                        return Column(
                          children: [
                            SettingsItemWidget(
                              onTap: () {
                                context.pushRoute(
                                  const ProfileSettingsRoute(),
                                );
                              },
                              itemName: 'Profile Settings',
                              itemAssetIcon:
                                  Assets.settings.profileSettings.svg(),
                            ),
                            h12,
                            SettingsItemWidget(
                              onTap: () {
                                context.pushRoute(
                                  NotificationSettingsRoute(
                                    notificationSettings:
                                        userInfo.notificationSettings,
                                  ),
                                );
                              },
                              itemName: 'Notifications',
                              itemAssetIcon:
                                  Assets.settings.notifications.svg(),
                            ),
                            h12,
                            SettingsItemWidget(
                              onTap: () {
                                context.pushRoute(
                                  LanguagesSettingsRoute(
                                    language: userInfo.language,
                                  ),
                                );
                              },
                              itemName: 'Languages',
                              itemAssetIcon: Assets.settings.languages.svg(),
                            ),
                            // h12,
                            // SettingsItemWidget(
                            //   onTap: () {
                            //     context.pushRoute(
                            //       EpicGamesSettingsRoute(
                            //         epicGamesAccountName:
                            //             userInfo.epicGamesUsername,
                            //       ),
                            //     );
                            //   },
                            //   itemName: 'Epic Games account',
                            //   itemAssetIcon: Assets.settings.epicGames.svg(),
                            // ),
                            h12,
                            SettingsItemWidget(
                              onTap: () {
                                context.pushRoute(
                                  RegionSettingsRoute(
                                    regions: userInfo.regions ?? [],
                                  ),
                                );
                              },
                              itemName: 'Region',
                              itemAssetIcon: Assets.settings.region.svg(),
                            ),
                            h12,
                            SettingsItemWidget(
                              onTap: () {
                                context.pushRoute(
                                  const BlockedUsersSettingsRoute(),
                                );
                              },
                              itemName: 'Blocked users',
                              itemAssetIcon: Assets.settings.blockedUsers.svg(),
                            ),
                          ],
                        );
                      },
                      error: (error) {
                        return const SizedBox();
                      },
                    );
                  },
                ),
                h12,
                SettingsItemWidget(
                  onTap: () {
                    openUrl(
                      url:
                          'http://tm8-frontend-d-lan-d3s8.s3-website-us-east-1.amazonaws.com/privacy-policy',
                    );
                  },
                  itemName: 'Privacy',
                  itemAssetIcon: Assets.settings.privacy.svg(),
                ),
                h12,
                SettingsItemWidget(
                  onTap: () {
                    openUrl(
                      url:
                          'http://tm8-frontend-d-lan-d3s8.s3-website-us-east-1.amazonaws.com/terms-of-service',
                    );
                  },
                  itemName: 'Terms of Service',
                  itemAssetIcon: Assets.settings.privacy.svg(),
                ),
                h12,
                SettingsItemWidget(
                  onTap: () async {
                    await launchUrl(
                      Uri.parse('mailto:tm8business@tm8gaming.com'),
                    );
                  },
                  itemName: 'Contact center',
                  itemAssetIcon: Assets.settings.contactCenter.svg(),
                ),
                h12,
                SettingsItemWidget(
                  onTap: () {
                    context.pushRoute(
                      const DeleteAccountSettingsRoute(),
                    );
                  },
                  itemName: 'Delete my account',
                  itemAssetIcon: Assets.settings.deleteAccount.svg(),
                  itemNameColor: errorColor,
                ),
                h24,
                GestureDetector(
                  onTap: () {
                    tm8PopUpDialogWidget(
                      context,
                      padding: 12,
                      width: 320,
                      borderRadius: 20,
                      popup: (context) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Log out',
                                style: heading4Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Assets.common.x.svg(),
                              ),
                            ],
                          ),
                          h12,
                          Text(
                            'Are you sure you want to log out?',
                            style: body1Regular.copyWith(
                              color: achromatic200,
                            ),
                          ),
                          h12,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Tm8MainButtonWidget(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                width: 130,
                                buttonColor: achromatic500,
                                text: 'Stay logged in',
                              ),
                              w8,
                              Tm8MainButtonWidget(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  sl<AppBloc>().add(const AppEvent.logOut());
                                },
                                width: 130,
                                buttonColor: errorColor,
                                text: 'Log out',
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.settings.logout.svg(),
                      w6,
                      Text(
                        'Log out',
                        style: body1Regular.copyWith(
                          color: achromatic100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openUrl({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
