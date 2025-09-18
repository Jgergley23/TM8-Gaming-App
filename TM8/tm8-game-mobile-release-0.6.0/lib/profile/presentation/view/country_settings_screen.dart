import 'package:auto_route/auto_route.dart';
import 'package:country_picker/country_picker.dart';
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
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //CountrySettingsScreen.page
class CountrySettingsScreen extends StatefulWidget {
  const CountrySettingsScreen({super.key, required this.country});

  final String? country;

  @override
  State<CountrySettingsScreen> createState() => _CountrySettingsScreenState();
}

class _CountrySettingsScreenState extends State<CountrySettingsScreen> {
  final updateUserInfoCubit = sl<UpdateUserInfoCubit>();
  Country? selectedCountry;

  @override
  initState() {
    super.initState();
    if (widget.country != null) {
      selectedCountry = Country.parse(widget.country!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: BlocProvider(
        create: (context) => updateUserInfoCubit,
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
                    text: 'Country updated successfully',
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
                  if (selectedCountry != null) {
                    updateUserInfoCubit.updateCountry(
                      body: ChangeUserInfoInput(
                        country: selectedCountry!.name,
                      ),
                    );
                  }
                },
                title: 'Select country',
                leading: true,
                navigationPadding: const EdgeInsets.only(top: 12, left: 12),
                action: true,
                actionIcon: Assets.settings.checkmark.svg(),
                actionPadding: EdgeInsets.zero,
              ),
              body: SingleChildScrollView(
                padding: screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    h12,
                    if (widget.country != null || selectedCountry != null) ...[
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
                            Row(
                              children: [
                                Text(
                                  selectedCountry?.flagEmoji ?? '',
                                  style: body1Regular.copyWith(
                                    color: achromatic100,
                                  ),
                                ),
                                w8,
                                Text(
                                  selectedCountry?.name ?? '',
                                  style: body1Regular.copyWith(
                                    color: achromatic100,
                                  ),
                                ),
                              ],
                            ),
                            Assets.settings.selectedCountry.svg(),
                          ],
                        ),
                      ),
                      h12,
                    ],
                    Text(
                      'Countries',
                      style: body1Regular.copyWith(color: achromatic200),
                    ),
                    h12,
                    Tm8MainButtonWidget(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: achromatic700,
                            textStyle:
                                body1Regular.copyWith(color: achromatic100),
                            bottomSheetHeight: 600,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country) {
                            setState(() {
                              selectedCountry = country;
                            });
                          },
                        );
                      },
                      text: 'Select country',
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
}
