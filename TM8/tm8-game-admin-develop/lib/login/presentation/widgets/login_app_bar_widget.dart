import 'package:flutter/material.dart';
import 'package:tm8_game_admin/login/presentation/widgets/login_logo_widget.dart';

class LoginAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        LoginLogoWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
