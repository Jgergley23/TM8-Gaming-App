import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/constants/validators.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/update_username_cubit/update_username_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //ProfileRoute.page
class DisplayNameSettingsScreen extends StatefulWidget {
  const DisplayNameSettingsScreen({super.key, required this.userName});

  final String userName;

  @override
  State<DisplayNameSettingsScreen> createState() =>
      _DisplayNameSettingsScreenState();
}

class _DisplayNameSettingsScreenState extends State<DisplayNameSettingsScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final updateUsernameCubit = sl<UpdateUsernameCubit>();
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: BlocProvider(
        create: (context) => updateUsernameCubit,
        child: BlocListener<UpdateUsernameCubit, UpdateUsernameState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: () {
                context.loaderOverlay.hide();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.maybePop();
                });
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  Tm8SnackBar.snackBar(
                    color: glassEffectColor,
                    text: 'Username updated successfully',
                    error: false,
                  ),
                );
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
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Tm8BodyContainerWidget(
              child: FormBuilder(
                key: formKey,
                child: Scaffold(
                  appBar: Tm8MainAppBarScaffoldWidget(
                    onActionPressed: () {
                      final currentState = formKey.currentState;
                      if (currentState!.saveAndValidate()) {
                        final username =
                            currentState.fields['username']!.value as String;
                        if (username != widget.userName) {
                          updateUsernameCubit.updateUsername(
                            body: UpdateUsernameInput(
                              username: username,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            Tm8SnackBar.snackBar(
                              color: glassEffectColor,
                              text: 'Cannot update with the same username',
                              error: false,
                            ),
                          );
                        }
                      }
                    },
                    title: 'Display name',
                    leading: true,
                    navigationPadding: const EdgeInsets.only(top: 12, left: 12),
                    action: true,
                    actionIcon: Assets.settings.checkmark.svg(),
                    actionPadding: EdgeInsets.zero,
                  ),
                  body: Padding(
                    padding: screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Tm8InputFormWidget(
                          name: 'username',
                          hintText: 'Username',
                          validator: usernameValidator,
                          labelText: 'Username',
                          initialValue: widget.userName,
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
