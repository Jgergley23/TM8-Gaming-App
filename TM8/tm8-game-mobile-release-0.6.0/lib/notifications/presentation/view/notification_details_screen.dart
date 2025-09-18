import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //NotificationsRoute.page
class NotificationDetailsScreen extends StatefulWidget {
  const NotificationDetailsScreen({
    super.key,
    required this.notification,
  });

  final NotificationResponse notification;

  @override
  State<NotificationDetailsScreen> createState() =>
      _NNotificationDetailsScreenState();
}

class _NNotificationDetailsScreenState
    extends State<NotificationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Tm8BodyContainerWidget(
      child: Scaffold(
        appBar: Tm8MainAppBarScaffoldWidget(
          title: 'Notification',
          leading: true,
          navigationPadding: screenPadding,
        ),
        body: SingleChildScrollView(
          padding: screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h12,
              Text(
                widget.notification.data.title,
                style: heading3Regular.copyWith(
                  color: achromatic100,
                ),
              ),
              h12,
              Text(
                widget.notification.data.description,
                style: body1Regular.copyWith(
                  color: achromatic200,
                ),
                textAlign: TextAlign.left,
              ),
              h12,
              // maybe add this later after mvp
              if (widget.notification.data.redirectScreen
                  .contains('CallScreen')) ...[
                Tm8MainButtonWidget(
                  onTap: () {
                    final call =
                        widget.notification.data.redirectScreen.split('/');
                    context.router.push(
                      CallRoute(
                        userCallId: call[1],
                        username: call.last,
                        callId: call[1],
                      ),
                    );
                  },
                  text: 'Answer call',
                  buttonColor: primaryTeal,
                ),
              ] else if (widget.notification.data.redirectScreen
                  .contains('match')) ...[
                Tm8MainButtonWidget(
                  onTap: () {
                    final match =
                        widget.notification.data.redirectScreen.split('/');
                    context
                        .pushRoute(
                      MessagingRoute(
                        userId: match.last,
                        username: match[1],
                      ),
                    )
                        .whenComplete(() {
                      sl<FetchChannelsCubit>().refetchMessages();
                    });
                  },
                  text: 'Send message',
                  buttonColor: primaryTeal,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
