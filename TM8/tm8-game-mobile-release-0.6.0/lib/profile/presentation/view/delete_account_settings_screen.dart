import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/app_bloc/app_bloc.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/delete_my_account_cubit/delete_my_account_cubit.dart';

@RoutePage() //DeleteAccountSettingsRoute.page
class DeleteAccountSettingsScreen extends StatefulWidget {
  const DeleteAccountSettingsScreen({
    super.key,
  });

  @override
  State<DeleteAccountSettingsScreen> createState() =>
      _DeleteAccountSettingsScreenState();
}

class _DeleteAccountSettingsScreenState
    extends State<DeleteAccountSettingsScreen> {
  final deleteMyAccountCubit = sl<DeleteMyAccountCubit>();
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: BlocProvider(
        create: (context) => deleteMyAccountCubit,
        child: BlocListener<DeleteMyAccountCubit, DeleteMyAccountState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: () {
                context.loaderOverlay.hide();
                sl<AppBloc>().add(
                  const AppEvent.delete(
                    message: 'Your account has been deleted.',
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
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              appBar: Tm8MainAppBarScaffoldWidget(
                title: 'Delete account',
                leading: true,
                navigationPadding: screenPadding,
              ),
              body: Padding(
                padding: screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    h12,
                    Text(
                      'Are you sure you want to delete your account? By deleting your account you will lose all your account information and gaming preferences.',
                      style: body1Regular.copyWith(
                        color: achromatic200,
                      ),
                    ),
                    expanded,
                    Tm8MainButtonWidget(
                      onTap: () {
                        deleteMyAccountCubit.deleteMyAccount();
                      },
                      buttonColor: errorColor,
                      text: 'Delete my account',
                    ),
                    h12,
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
