import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/games/presentation/logic/check_user_cubit/check_user_cubit.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //MatchRoute.page
class MatchScreen extends StatefulWidget {
  const MatchScreen({
    super.key,
    required this.game,
    required this.matchUserId,
  });

  final String game;
  final String matchUserId;

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final checkUserCubit = sl<CheckUserCubit>();

  String username = 'User';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => checkUserCubit
        ..checkUser(
          matchUserId: widget.matchUserId,
        ),
      child: BlocListener<CheckUserCubit, CheckUserState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (profileMatch, profileUser) {
              username = profileMatch.username;
            },
          );
        },
        child: Tm8BodyContainerWidget(
          child: Scaffold(
            appBar: Tm8MainAppBarScaffoldWidget(
              title: 'Match',
              leading: false,
              navigationPadding: screenPadding,
            ),
            body: Padding(
              padding: screenPadding,
              child: Column(
                children: [
                  h100,
                  Text(
                    'It’s a match!',
                    style: heading2Regular.copyWith(
                      color: achromatic100,
                    ),
                  ),
                  h24,
                  Text(
                    'You and this user both chose each other to play. Send a message now and start playing!',
                    style: body1Regular.copyWith(
                      color: achromatic200,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  h80,
                  BlocBuilder<CheckUserCubit, CheckUserState>(
                    builder: (context, state) {
                      return state.when(
                        initial: SizedBox.new,
                        loading: () {
                          return _buildLoadingMatchScreen();
                        },
                        loaded: (profileMatch, profileUser) {
                          return _buildLoadedProfiles(
                            profileMatch,
                            profileUser,
                          );
                        },
                        error: (error) {
                          return Tm8ErrorWidget(
                            onTapRetry: () {
                              checkUserCubit.checkUser(
                                matchUserId: widget.matchUserId,
                              );
                            },
                            error: error,
                          );
                        },
                      );
                    },
                  ),
                  expanded,
                  Tm8MainButtonWidget(
                    onTap: () {
                      sl<FetchChannelsCubit>().fetchChannels(
                        username: null,
                      );
                      context
                          .pushRoute(
                        MessagingRoute(
                          userId: widget.matchUserId,
                          username: username,
                        ),
                      )
                          .whenComplete(() {
                        sl<FetchChannelsCubit>().refetchMessages();
                        context.router.pushAndPopUntil(
                          const HomePageRoute(),
                          predicate: (_) => false,
                        );
                      });
                    },
                    buttonColor: primaryTeal,
                    text: 'Send message',
                  ),
                  h12,
                  Tm8MainButtonWidget(
                    onTap: () {
                      context.router.maybePop();
                    },
                    buttonColor: achromatic500,
                    text: 'Keep matching',
                  ),
                  h20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Skeletonizer _buildLoadingMatchScreen() {
    return Skeletonizer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                height: 92,
                width: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: achromatic600,
                ),
                child: Center(
                  child: Text(
                    'U',
                    style: heading4Bold.copyWith(
                      color: achromatic100,
                    ),
                  ),
                ),
              ),
              h8,
              Text(
                'Username',
                style: heading4Bold.copyWith(
                  color: achromatic100,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 92,
                width: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: achromatic600,
                ),
                child: Center(
                  child: Text(
                    'U',
                    style: heading4Bold.copyWith(
                      color: achromatic100,
                    ),
                  ),
                ),
              ),
              h8,
              Text(
                'Username',
                style: heading4Bold.copyWith(
                  color: achromatic100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _buildLoadedProfiles(
    UserProfileResponse profileMatch,
    GetMeUserResponse profileUser,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            if (profileMatch.photo == null) ...[
              Container(
                height: 92,
                width: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: achromatic600,
                ),
                child: Center(
                  child: Text(
                    profileMatch.username[0].toUpperCase(),
                    style: heading4Bold.copyWith(
                      color: achromatic100,
                    ),
                  ),
                ),
              ),
            ] else ...[
              ClipOval(
                child: Image.network(
                  '${Env.stagingUrlAmazon}/${profileMatch.photo}',
                  height: 92,
                  width: 92,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
            h8,
            Text(
              profileMatch.username,
              style: heading4Bold.copyWith(
                color: achromatic100,
              ),
            ),
          ],
        ),
        Column(
          children: [
            if (profileUser.photoKey == null) ...[
              Container(
                height: 92,
                width: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: achromatic600,
                ),
                child: Center(
                  child: Text(
                    profileUser.username[0].toUpperCase(),
                    style: heading4Bold.copyWith(
                      color: achromatic100,
                    ),
                  ),
                ),
              ),
            ] else ...[
              ClipOval(
                child: Image.network(
                  '${Env.stagingUrlAmazon}/${profileUser.photoKey}',
                  height: 92,
                  width: 92,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
            h8,
            Text(
              profileUser.username,
              style: heading4Bold.copyWith(
                color: achromatic100,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
