import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/actions_controller_cubit/actions_controller_cubit.dart';

class UserDetailsActionsWidget extends StatelessWidget {
  const UserDetailsActionsWidget({
    super.key,
    required this.onWarningPressed,
    required this.onSuspensionPressed,
    required this.onBanPressed,
    required this.user,
    required this.onResetPressed,
  });

  final VoidCallback onWarningPressed;
  final VoidCallback onSuspensionPressed;
  final VoidCallback onBanPressed;
  final UserResponse user;
  final VoidCallback onResetPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionsControllerCubit, bool>(
      builder: (context, state) {
        return Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              'User profile',
              style: heading1Regular.copyWith(color: achromatic100),
            ),
            Wrap(
              children: [
                if (user.status?.type == UserStatusResponseType.banned) ...[
                  Tm8MainButtonWidget(
                    onPressed: () {
                      if (state) {
                        onResetPressed();
                      }
                    },
                    buttonColor: achromatic600,
                    text: 'Reset',
                    width: 90,
                    asset: Assets.user.userReset.path,
                  ),
                ] else if (user.status?.type ==
                    UserStatusResponseType.suspended) ...[
                  Tm8MainButtonWidget(
                    onPressed: () {
                      if (state) {
                        onResetPressed();
                      }
                    },
                    buttonColor: achromatic600,
                    text: 'Reset',
                    width: 90,
                    asset: Assets.user.userReset.path,
                  ),
                  w8,
                  Tm8MainButtonWidget(
                    onPressed: () {
                      if (state) {
                        onBanPressed();
                      }
                    },
                    buttonColor: errorColor.withOpacity(0.17),
                    text: 'Ban',
                    textColor: errorColor,
                    width: 75,
                    asset: Assets.user.userBan.path,
                  ),
                ] else ...[
                  Tm8MainButtonWidget(
                    onPressed: () {
                      if (state) {
                        onWarningPressed();
                      }
                    },
                    buttonColor: achromatic600,
                    text: 'Send Warning',
                    width: 135,
                    asset: Assets.user.userWarning.path,
                  ),
                  w8,
                  Tm8MainButtonWidget(
                    onPressed: () {
                      if (state) {
                        onSuspensionPressed();
                      }
                    },
                    buttonColor: achromatic600,
                    text: 'Suspend',
                    width: 105,
                    asset: Assets.user.userSuspended.path,
                  ),
                  w8,
                  Tm8MainButtonWidget(
                    onPressed: () {
                      if (state) {
                        onBanPressed();
                      }
                    },
                    buttonColor: errorColor.withOpacity(0.17),
                    text: 'Ban',
                    textColor: errorColor,
                    width: 75,
                    asset: Assets.user.userBan.path,
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}
