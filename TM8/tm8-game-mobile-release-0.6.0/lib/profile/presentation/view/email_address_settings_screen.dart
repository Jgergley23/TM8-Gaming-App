import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';

@RoutePage() //EmailAddressSettingsRoute.page
class EmailAddressSettingsScreen extends StatefulWidget {
  const EmailAddressSettingsScreen({super.key, required this.email});

  final String email;

  @override
  State<EmailAddressSettingsScreen> createState() =>
      _EmailAddressSettingsScreenState();
}

class _EmailAddressSettingsScreenState
    extends State<EmailAddressSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Tm8BodyContainerWidget(
      child: Scaffold(
        appBar: Tm8MainAppBarScaffoldWidget(
          title: 'Email address',
          leading: true,
          navigationPadding: screenPadding,
        ),
        body: Padding(
          padding: screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: achromatic600,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.email,
                      style: body1Regular.copyWith(
                        color: achromatic100,
                      ),
                    ),
                  ],
                ),
              ),
              expanded,
              Tm8MainButtonWidget(
                onTap: () {
                  context.pushRoute(const ChangeEmailSettingsRoute());
                },
                buttonColor: primaryTeal,
                text: 'Change email address',
              ),
              h20,
            ],
          ),
        ),
      ),
    );
  }
}
