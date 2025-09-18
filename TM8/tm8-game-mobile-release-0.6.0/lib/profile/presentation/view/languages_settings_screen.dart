import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/update_user_info_cubit/update_user_info_cubit.dart';
import 'package:tm8/profile/presentation/widgets/languages_picker.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //LanguagesSettingsRoute.page
class LanguagesSettingsScreen extends StatefulWidget {
  const LanguagesSettingsScreen({super.key, required this.language});

  final String? language;

  @override
  State<LanguagesSettingsScreen> createState() =>
      _LanguagesSettingsScreenState();
}

class _LanguagesSettingsScreenState extends State<LanguagesSettingsScreen> {
  final updateUserInfoCubit = sl<UpdateUserInfoCubit>();
  String? selectedLanguage;

  @override
  initState() {
    super.initState();
    if (widget.language != null) {
      selectedLanguage = widget.language;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => updateUserInfoCubit,
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return Tm8LoadingOverlayWidget(progress: progress);
        },
        overlayColor: Colors.transparent,
        child: BlocListener<UpdateUserInfoCubit, UpdateUserInfoState>(
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
                    text: 'Language updated successfully',
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
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              appBar: Tm8MainAppBarScaffoldWidget(
                onActionPressed: () {
                  updateUserInfoCubit.updatedLanguage(
                    body: ChangeUserInfoInput(
                      language: selectedLanguage,
                    ),
                  );
                },
                title: 'Language you speak',
                leading: true,
                navigationPadding: const EdgeInsets.only(top: 12, left: 12),
                action: true,
                actionIcon: Assets.settings.checkmark.svg(),
                actionPadding: EdgeInsets.zero,
              ),
              body: Padding(
                padding: screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    h12,
                    if (widget.language != null ||
                        selectedLanguage != null) ...[
                      Text(
                        'Currently selected',
                        style: body1Regular.copyWith(color: achromatic200),
                      ),
                      h12,
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: achromatic600,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedLanguage!,
                              style: body1Regular.copyWith(
                                color: achromatic100,
                              ),
                            ),
                            Assets.settings.selectedCountry.svg(),
                          ],
                        ),
                      ),
                      h12,
                    ],
                    Text(
                      'Languages',
                      style: body1Regular.copyWith(color: achromatic200),
                    ),
                    h12,
                    Tm8MainButtonWidget(
                      onTap: () {
                        _openLanguagePickerDialog();
                      },
                      text: 'Select Language',
                      buttonColor: primaryTeal,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => LanguagePickerDialog(
          titlePadding: const EdgeInsets.all(8.0),
          searchInputDecoration: const InputDecoration(hintText: 'Search...'),
          isSearchable: true,
          title: Text(
            'Select your language',
            style: body1Regular.copyWith(
              color: achromatic100,
            ),
          ),
          onValuePicked: (Language language) => setState(() {
            selectedLanguage = language.name;
          }),
        ),
      );
}
