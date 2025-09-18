import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/constants/validators.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_bottom_sheet_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_secondary_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/profile/presentation/logic/selected_date_cubit/selected_date_cubit.dart';
import 'package:tm8/profile/presentation/logic/update_user_info_cubit/update_user_info_cubit.dart';
import 'package:tm8/profile/presentation/logic/update_user_photo_cubit/update_user_photo_cubit.dart';
import 'package:tm8/profile/presentation/widgets/profile_settings_item_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //ProfileRoute.page
class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({
    super.key,
  });

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final updateUserPhotoCubit = sl<UpdateUserPhotoCubit>();
  final updateUserInfoCubit = sl<UpdateUserInfoCubit>();
  final selectedDateCubit = sl<SelectedDateCubit>();

  String date = '';

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => updateUserPhotoCubit,
          ),
          BlocProvider(
            create: (context) => updateUserInfoCubit,
          ),
          BlocProvider.value(
            value: sl<FetchUserProfileCubit>()..fetchUserProfile(),
          ),
          BlocProvider(
            create: (context) => selectedDateCubit,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<UpdateUserPhotoCubit, UpdateUserPhotoState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                    Navigator.of(context).pop();
                  },
                  loaded: (userFileResponse) {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'User photo updated successfully',
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
            ),
            BlocListener<UpdateUserInfoCubit, UpdateUserInfoState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: () {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'Date of Birth updated successfully',
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
            ),
            BlocListener<FetchUserProfileCubit, FetchUserProfileState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (userInfo) {
                    if (userInfo.dateOfBirth != null) {
                      selectedDateCubit
                          .changeDate(userInfo.dateOfBirth ?? DateTime.now());
                    }
                  },
                );
              },
            ),
            BlocListener<SelectedDateCubit, DateTime>(
              listener: (context, state) {
                date = DateFormat('yyyy-MM-dd').format(state);
              },
            ),
          ],
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              appBar: Tm8MainAppBarScaffoldWidget(
                title: 'Profile Settings',
                leading: true,
                navigationPadding: screenPadding,
              ),
              body: SingleChildScrollView(
                padding: screenPadding,
                child:
                    BlocBuilder<FetchUserProfileCubit, FetchUserProfileState>(
                  builder: (context, state) {
                    return state.when(
                      initial: SizedBox.new,
                      loading: () {
                        return _buildLoadingUserInfo(context);
                      },
                      loaded: (userInfo) {
                        return _buildLoadedUserInfo(context, userInfo);
                      },
                      error: (error) {
                        return Tm8ErrorWidget(
                          onTapRetry: () {
                            sl<FetchUserProfileCubit>().fetchUserProfile();
                          },
                          error: error,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Skeletonizer _buildLoadingUserInfo(BuildContext context) {
    return Skeletonizer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    height: 90,
                    width: 90,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 60),
                    child: Container(
                      width: 30,
                      height: 30,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: achromatic500,
                      ),
                      child: Center(
                        child: Assets.settings.addPhoto.svg(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          h8,
          Text(
            'username',
            style: heading4Bold.copyWith(color: achromatic100),
          ),
          h12,
          ProfileSettingsItemWidget(
            onTap: () {},
            itemName: 'Display name',
            itemValue: 'username',
          ),
          h12,
          if (sl<Tm8Storage>().signupType == 'manual') ...[
            ProfileSettingsItemWidget(
              onTap: () {},
              itemName: 'Email address',
              itemValue: sl<Tm8Storage>().userName,
            ),
            h12,
            ProfileSettingsItemWidget(
              onTap: () {},
              itemName: 'Password',
              itemValue: '*********',
            ),
            h12,
          ],
          ProfileSettingsItemWidget(
            onTap: () {},
            itemName: 'Description',
            itemValue: 'Add description',
          ),
          h12,
          ProfileSettingsItemWidget(
            onTap: () {},
            itemName: 'Audio intro',
            itemValue: 'Audio intro',
          ),
          h12,
          ProfileSettingsItemWidget(
            onTap: () {},
            itemName: 'Country',
            itemValue: 'Add country',
          ),
          h12,
          ProfileSettingsItemWidget(
            onTap: () {},
            itemName: 'Gender',
            itemValue: 'Add Gender',
          ),
          h12,
          ProfileSettingsItemWidget(
            onTap: () {},
            itemName: 'Birthday',
            itemValue: 'Add Birthday',
          ),
          h40,
        ],
      ),
    );
  }

  Column _buildLoadedUserInfo(
    BuildContext context,
    GetMeUserResponse userInfo,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            tm8BottomSheetWidget(
              context,
              onTap: (value) async {
                updateUserPhotoCubit.updateUserPhoto(value: value);
              },
              item: ['Take a photo', 'Chose image'],
              assetIcon: [
                Assets.settings.addPhoto.svg(),
                Assets.settings.chooseImage.svg(),
              ],
              colors: [achromatic100, achromatic100],
            );
          },
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                if (userInfo.photoKey == null) ...[
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: achromatic600,
                    ),
                    child: Center(
                      child: Text(
                        userInfo.username[0].toUpperCase(),
                        style: heading4Bold.copyWith(
                          color: achromatic100,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  ClipOval(
                    child: Image.network(
                      '${Env.stagingUrlAmazon}/${userInfo.photoKey}',
                      height: 90,
                      width: 90,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 60),
                  child: Container(
                    width: 30,
                    height: 30,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: achromatic500,
                    ),
                    child: Center(
                      child: Assets.settings.addPhoto.svg(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        h8,
        Text(
          userInfo.username,
          style: heading4Bold.copyWith(color: achromatic100),
        ),
        h12,
        ProfileSettingsItemWidget(
          onTap: () {
            context.pushRoute(
              DisplayNameSettingsRoute(
                userName: userInfo.username,
              ),
            );
          },
          itemName: 'Display name',
          itemValue: userInfo.username,
        ),
        h12,
        if (sl<Tm8Storage>().signupType == 'manual') ...[
          ProfileSettingsItemWidget(
            onTap: () {
              context.pushRoute(
                EmailAddressSettingsRoute(email: userInfo.email),
              );
            },
            itemName: 'Email address',
            itemValue: userInfo.email,
          ),
          h12,
          ProfileSettingsItemWidget(
            onTap: () {
              context.pushRoute(const ChangePasswordRoute());
            },
            itemName: 'Password',
            itemValue: '*********',
          ),
          h12,
        ],
        ProfileSettingsItemWidget(
          onTap: () {
            context.pushRoute(
              DescriptionSettingsRoute(
                description: userInfo.description,
              ),
            );
          },
          itemName: 'Description',
          itemValue: userInfo.description ?? 'Add description',
        ),
        h12,
        ProfileSettingsItemWidget(
          onTap: () {
            context.pushRoute(
              AudioIntroSettingsRoute(
                audioIntro: userInfo.audioKey,
              ),
            );
          },
          itemName: 'Audio intro',
          itemValue: 'Audio intro',
        ),
        h12,
        ProfileSettingsItemWidget(
          onTap: () {
            context.pushRoute(
              CountrySettingsRoute(
                country: userInfo.country,
              ),
            );
          },
          itemName: 'Country',
          itemValue: userInfo.country ?? 'Add country',
        ),
        h12,
        ProfileSettingsItemWidget(
          onTap: () {
            context.pushRoute(
              GenderSettingsRoute(
                gender: userInfo.gender,
              ),
            );
          },
          itemName: 'Gender',
          itemValue: userInfo.gender != null
              ? userInfo.gender.toString().capitalize()
              : 'Add Gender',
        ),
        h12,
        BlocBuilder<SelectedDateCubit, DateTime>(
          builder: (context, state) {
            return ProfileSettingsItemWidget(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: achromatic700,
                  barrierColor: overlayColor,
                  builder: (BuildContext builder) {
                    return dateOfBirthModal(context, state);
                  },
                );
              },
              itemName: 'Birthday',
              itemValue: userInfo.dateOfBirth != null
                  ? DateFormat(
                      'MMMM d\'${_getDaySuffix(userInfo.dateOfBirth!.day)}\' yyyy',
                    ).format(userInfo.dateOfBirth!)
                  : 'Add Birthday',
            );
          },
        ),
        h40,
      ],
    );
  }

  Container dateOfBirthModal(BuildContext context, DateTime selectedDate) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      color: achromatic700,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tm8SecondaryButtonWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                textColor: achromatic100,
                textStyle: body1Bold,
                text: 'Cancel',
              ),
              Tm8SecondaryButtonWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                  final result =
                      CustomDateValidator.validateDate(date.toString());
                  if (result == null) {
                    updateUserInfoCubit.updatedDateOfBirth(
                      body: ChangeUserInfoInput(
                        dateOfBirth: DateFormat(
                          'yyyy-MM-dd',
                        ).format(
                          DateTime.parse(date),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: result,
                        error: true,
                      ),
                    );
                  }
                },
                textColor: achromatic100,
                textStyle: body1Bold,
                text: 'Done',
              ),
            ],
          ),
          SizedBox(
            height: 150,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: heading4Regular.copyWith(
                    color: achromatic200,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                dateOrder: DatePickerDateOrder.dmy,
                initialDateTime: selectedDate,
                backgroundColor: achromatic700,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (newDate) {
                  selectedDateCubit.changeDate(newDate);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Function to get the suffix for the day (e.g., st, nd, rd, th)
String _getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
