import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/friends/presentation/logic/camera_permission_cubit/camera_permission_cubit.dart';
import 'package:tm8/friends/presentation/logic/fetch_friends_cubit/fetch_friends_cubit.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/messages/presentation/logic/add_friend_cubit/add_friend_cubit.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';

@RoutePage() //QRCodeRoute.page
class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  final String userId;
  final String userName;

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final addFriendCubit = sl<AddFriendCubit>();
  final cameraPermissionCubit = sl<CameraPermissionCubit>();
  PermissionStatus permissionStatus = PermissionStatus.granted;
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
            create: (context) => addFriendCubit,
          ),
          BlocProvider(
            create: (context) => cameraPermissionCubit..checkCameraPermission(),
          ),
          BlocProvider.value(
            value: sl<FetchUserProfileCubit>()..fetchUserProfile(),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AddFriendCubit, AddFriendState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: () {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'Friend successfully added',
                        error: false,
                      ),
                    );
                    sl<FetchFriendsCubit>().fetchFriends(username: null);
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
            BlocListener<CameraPermissionCubit, CameraPermissionState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (permissionStatus) {
                    this.permissionStatus = permissionStatus;
                  },
                );
              },
            ),
          ],
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              appBar: Tm8MainAppBarScaffoldWidget(
                title: '',
                leading: true,
                navigationPadding: screenPadding,
              ),
              body: Padding(
                padding: screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<FetchUserProfileCubit, FetchUserProfileState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loaded: (userProfile) {
                            if (userProfile.photoKey == null) {
                              return Container(
                                height: 64,
                                width: 64,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: achromatic600,
                                ),
                                child: Center(
                                  child: Text(
                                    widget.userName[0].toUpperCase(),
                                    style: heading4Bold.copyWith(
                                      color: achromatic100,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return ClipOval(
                                child: Image.network(
                                  '${Env.stagingUrlAmazon}/${userProfile.photoKey}',
                                  height: 64,
                                  width: 64,
                                  fit: BoxFit.fitWidth,
                                ),
                              );
                            }
                          },
                          orElse: SizedBox.new,
                        );
                      },
                    ),
                    h8,
                    Text(
                      widget.userName,
                      style: heading4Bold.copyWith(
                        color: achromatic100,
                      ),
                    ),
                    h24,
                    Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: achromatic600,
                      ),
                      child: Center(
                        child: QrImageView(
                          data: widget.userId,
                          version: QrVersions.auto,
                          size: 180,
                          backgroundColor: achromatic100,
                        ),
                      ),
                    ),
                    expanded,
                    Tm8MainButtonWidget(
                      onTap: () {
                        context.pushRoute(
                          QRCodeScanningRoute(
                            onCapture: (value) {
                              addFriendCubit.addFriend(
                                userId: value,
                                username: widget.userName,
                              );
                            },
                            permissionStatus: permissionStatus,
                          ),
                        );
                      },
                      buttonColor: primaryTeal,
                      text: 'Scan Code',
                    ),
                    h12,
                    Tm8MainButtonWidget(
                      onTap: () {
                        context.maybePop();
                      },
                      buttonColor: achromatic500,
                      text: 'Cancel',
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
