import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_container_widget.dart';
import 'package:tm8_game_admin/login/presentation/widgets/login_app_bar_widget.dart';

class ForgotPasswordConformationScreen extends StatelessWidget {
  const ForgotPasswordConformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoginAppBarWidget(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Tm8MainContainerWidget(
                  width: 340,
                  padding: 24,
                  borderRadius: 20,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Password reset successfully!',
                        style: heading1Regular.copyWith(
                          color: achromatic100,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      h12,
                      Text(
                        'You have successfully reset your password. Use the new password to log in to the platform from now on.',
                        style: body1Regular.copyWith(
                          color: achromatic200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      h24,
                      Tm8MainButtonWidget(
                        onPressed: () {
                          context.beamToReplacementNamed(login);
                        },
                        buttonColor: primaryTeal,
                        text: 'Continue to Login',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
