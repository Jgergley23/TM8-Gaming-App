import 'package:auto_size_text/auto_size_text.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:tm8l/app/constants/constants.dart';
import 'package:tm8l/app/constants/fonts.dart';
import 'package:tm8l/app/constants/palette.dart';
import 'package:tm8l/app/constants/routing_names.dart';
import 'package:tm8l/app/services/service_locator.dart';
import 'package:tm8l/gen/assets.gen.dart';
import 'package:tm8l/landing_page/logic/testimonial_control_cubit/testimonial_control_cubit.dart';
import 'package:tm8l/landing_page/widgets/landing_page_button_widget.dart';
import 'package:tm8l/landing_page/widgets/landing_page_footer_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final now = DateTime.now();
  final launchDate = DateTime(2024, 9, 25);
  var diff = Duration.zero;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    diff = launchDate.difference(now);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TestimonialControlCubit>(),
      child: LayoutBuilder(
        builder: (context, constrains) {
          final maxWidth = constrains.maxWidth;
          final isSmallScreen = maxWidth < 768;
          return ListView(
            children: [
              isSmallScreen ? h32 : h96,
              _buildIntroHomeWidget(maxWidth),
              isSmallScreen ? h32 : h96,
              _buildFeaturesWidget(maxWidth, isSmallScreen),
              isSmallScreen ? h32 : h96,
              _buildCompanyWidget(maxWidth, isSmallScreen),
              h20,
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: isSmallScreen ? 32 : 112),
                child: Text(
                  'These images are property of Epic Games and Activation. TM8 does not endorse nor have any affiliation. More information will be found at the bottom of the page.',
                  style: landingPageBodyRegular.copyWith(
                    color: achromatic200,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              isSmallScreen ? h32 : h96,
              _buildLaunchDayWidget(maxWidth, isSmallScreen),
              // isSmallScreen ? h32 : h96,
              // _buildTestimonialWidget(maxWidth, isSmallScreen),
              isSmallScreen ? h32 : h96,
              _buildGoalsWidget(maxWidth, isSmallScreen),
              isSmallScreen ? h32 : h96,
              LandingPageFooterWidget(
                onPressed: (value) {
                  if (value == 0) {
                    context.beamToNamed(home, data: value);
                  } else if (value == 1) {
                    context.beamToNamed(about, data: value);
                  } else if (value == 2) {
                    context.beamToNamed(contact, data: value);
                  }
                },
                isSmallScreen: isSmallScreen,
                maxWidth: maxWidth,
              ),
            ],
          );
        },
      ),
    );
  }

  Container _buildGoalsWidget(double maxWidth, bool isSmallScreen) {
    return Container(
      color: achromatic800,
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 32 : 112),
      child: Column(
        children: [
          isSmallScreen ? h32 : h96,
          SizedBox(
            width: maxWidth,
            child: Wrap(
              runSpacing: 20,
              alignment: WrapAlignment.spaceBetween,
              children: [
                if (!isSmallScreen)
                  Image.asset(
                    Assets.images.goal.path,
                    width: 576,
                    height: 512,
                  ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 544),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Features',
                        style: landingPageOverlineBold.copyWith(
                          color: primaryTealText,
                        ),
                      ),
                      h8,
                      Text(
                        'Our Goal',
                        style:
                            landingPageHeading3.copyWith(color: achromatic100),
                      ),
                      h16,
                      AutoSizeText(
                        'At TM8, we recognize the challenges that can arise when teammates are not aligned in skill level or commitment, impacting the overall gaming experience. Our mission is to elevate the gaming community by fostering connections among like-minded individuals who share similar gaming preferences and aspirations. Through our platform, we aim to curate optimal gaming groups, ensuring compatibility in skill levels and dedication to enhance the overall gameplay experience. TM8 is committed to creating a space where players can collaborate seamlessly, minimizing frustrations associated with uneven teamwork and maximizing the potential for victories. Join us for the ultimate gaming experience, where teamwork and shared goals converge for unparalleled success.',
                        style: landingPageBodyRegular.copyWith(
                          color: achromatic200,
                        ),
                        textAlign: TextAlign.justify,
                        maxFontSize: isSmallScreen ? 16 : 20,
                        minFontSize: 14,
                      ),
                    ],
                  ),
                ),
                if (isSmallScreen) ...[
                  h16,
                  Image.asset(
                    Assets.images.goal.path,
                    width: 576,
                    height: 512 / 2,
                  ),
                ],
              ],
            ),
          ),
          isSmallScreen ? h24 : h64,
          SizedBox(
            width: maxWidth,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 20,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 544),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!isSmallScreen)
                        Image.asset(
                          Assets.images.mission.path,
                          width: 576,
                          height: 512,
                        ),
                      h16,
                      Text(
                        'Our Mission',
                        style:
                            landingPageHeading3.copyWith(color: achromatic100),
                      ),
                      h16,
                      AutoSizeText(
                        'At TM8 Gaming our mission is to enhance the gaming experience by connecting players with their perfect teammates. Every gamer has had that random teammate that goes AFK, quits the game or just isn’t at your skill level. We are here to change that narrative and help you connect with real users in real time to create the best gaming experience and get you winning more games. Through AI-driven matchmaking, we empower gamers to win more games and enjoy a better gaming experience, fostering a community of camaraderie and success. ',
                        style: landingPageBodyRegular.copyWith(
                          color: achromatic200,
                        ),
                        textAlign: TextAlign.justify,
                        maxFontSize: isSmallScreen ? 16 : 20,
                        minFontSize: 14,
                      ),
                      if (isSmallScreen) ...[
                        h16,
                        Image.asset(
                          Assets.images.mission.path,
                          width: 576,
                          height: 512 / 2,
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 544),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!isSmallScreen)
                        Image.asset(
                          Assets.images.history.path,
                          width: 576,
                          height: 512,
                        ),
                      h16,
                      Text(
                        'Our History',
                        style:
                            landingPageHeading3.copyWith(color: achromatic100),
                      ),
                      h16,
                      AutoSizeText(
                        'Founded in 2023, TM8 has been in development for a year now to make sure that our algorithm for finding teammates is the best we can offer. Using top notch developers in both software and Ai has brought us to this point and we can’t wait to share TM8 with the world.',
                        style: landingPageBodyRegular.copyWith(
                          color: achromatic200,
                        ),
                        textAlign: TextAlign.justify,
                        maxFontSize: isSmallScreen ? 16 : 20,
                        minFontSize: 14,
                      ),
                      if (isSmallScreen) ...[
                        h16,
                        Image.asset(
                          Assets.images.goalAsset.path,
                          width: 576,
                          height: 512 / 2,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          isSmallScreen ? h32 : h96,
          _buildStartToday(maxWidth, isSmallScreen),
          isSmallScreen ? h32 : h96,
        ],
      ),
    );
  }

  Container _buildStartToday(double maxWidth, bool isSmallScreen) {
    return Container(
      width: maxWidth,
      decoration: BoxDecoration(
        color: achromatic600,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(64),
      child: Wrap(
        runSpacing: 20,
        alignment: WrapAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start matching today',
                style: landingPageHeading3.copyWith(
                  color: achromatic100,
                ),
              ),
              h16,
              AutoSizeText(
                'And discover the power of matchmaking technology to find your perfect teammate.',
                style: landingPageBodyRegular.copyWith(
                  color: achromatic200,
                ),
                maxFontSize: isSmallScreen ? 16 : 20,
                minFontSize: 14,
              ),
            ],
          ),
          LandingPageButtonWidget(
            onPressed: () {},
            text: 'Get started',
            buttonColor: primaryTeal,
          ),
        ],
      ),
    );
  }

  // Padding _buildTestimonialWidget(double maxWidth, bool isSmallScreen) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: maxWidth < 900 ? 32 : 112),
  //     child: BlocBuilder<TestimonialControlCubit, List<int>>(
  //       builder: (context, state) {
  //         return SizedBox(
  //           height: isSmallScreen ? 550 : 450,
  //           child: PageView(
  //             scrollDirection: Axis.horizontal,
  //             controller: pageController,
  //             children: [
  //               if (maxWidth < 900) ...[
  //                 for (int i = 0; i < 4; i++) ...[
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       _buildTestimonialItem(true),
  //                     ],
  //                   ),
  //                 ],
  //               ] else
  //                 for (int i = 0; i < 2; i++) ...[
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       _buildTestimonialItem(isSmallScreen),
  //                       w20,
  //                       _buildTestimonialItem(isSmallScreen),
  //                       w20,
  //                     ],
  //                   ),
  //                 ],
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // Container _buildTestimonialItem(bool isSmallScreen) {
  //   return Container(
  //     constraints: BoxConstraints(maxWidth: isSmallScreen ? 280 : 502),
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: achromatic500,
  //         width: 2,
  //       ),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     padding: const EdgeInsets.all(32),
  //     child: Column(
  //       children: [
  //         AutoSizeText(
  //           'Lorem ipsum dolor sit amet consectetur. Non a elementum sed eget vestibulum fusce egestas magna. In sollicitudin malesuada vel arcu feugiat pretium. Odio bibendum tortor mauris dictum cras vel luctus sagittis ut. Viverra vitae sagittis sed mi fringilla et. Hendrerit purus aenean mi in. ',
  //           style: landingPageBodyRegular.copyWith(
  //             color: achromatic200,
  //           ),
  //           maxFontSize: isSmallScreen ? 16 : 20,
  //           minFontSize: 14,
  //           textAlign: TextAlign.justify,
  //         ),
  //         h32,
  //         Image.asset(
  //           Assets.images.testimonialPicture.path,
  //           width: 64,
  //           height: 64,
  //         ),
  //         h16,
  //         Text(
  //           'Koray Okumus',
  //           style: landingPageBodyBold.copyWith(
  //             color: achromatic100,
  //           ),
  //         ),
  //         h4,
  //         Text(
  //           'Lorem ipsum dolor sit amet',
  //           style: landingPageOverlineBold.copyWith(
  //             color: achromatic200,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Container _buildLaunchDayWidget(double maxWidth, bool isSmallScreen) {
    return Container(
      color: achromatic800,
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 32 : 112),
      child: Column(
        children: [
          isSmallScreen ? h32 : h96,
          Text(
            'Almost there',
            style: landingPageOverlineBold.copyWith(
              color: primaryTealText,
            ),
          ),
          h12,
          Text(
            'Launch Day is Coming Soon!',
            style: landingPageHeading2.copyWith(
              color: achromatic100,
            ),
          ),
          h20,
          AutoSizeText(
            'Countdown the days before our launch with our pre launch giveaways and events!',
            style: landingPageBodyRegular.copyWith(
              color: achromatic200,
            ),
            maxFontSize: isSmallScreen ? 16 : 20,
            minFontSize: 14,
          ),
          isSmallScreen ? h24 : h64,
          Countdown(
            seconds: diff.inSeconds,
            build: (context, double time) {
              final duration = Duration(seconds: time.toInt());
              if (isSmallScreen) {
                return SizedBox(
                  width: maxWidth,
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 20,
                        children: [
                          Container(
                            constraints: const BoxConstraints(minWidth: 100),
                            child: Column(
                              children: [
                                Text(
                                  duration.inDays.toString(),
                                  style: landingPageHeading1.copyWith(
                                    color: primaryTealText,
                                  ),
                                ),
                                h12,
                                Text(
                                  'Days',
                                  style: landingPageBodyBold.copyWith(
                                    color: achromatic100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          w4,
                          Container(
                            color: achromatic500,
                            width: 2,
                            height: 112,
                          ),
                          w4,
                          Container(
                            constraints: const BoxConstraints(minWidth: 100),
                            child: Column(
                              children: [
                                Text(
                                  duration.inHours.remainder(24).toString(),
                                  style: landingPageHeading1.copyWith(
                                    color: primaryTealText,
                                  ),
                                ),
                                h12,
                                Text(
                                  'Hours',
                                  style: landingPageBodyBold.copyWith(
                                    color: achromatic100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 20,
                        children: [
                          Container(
                            constraints: const BoxConstraints(minWidth: 100),
                            child: Column(
                              children: [
                                Text(
                                  duration.inMinutes.remainder(60).toString(),
                                  style: landingPageHeading1.copyWith(
                                    color: primaryTealText,
                                  ),
                                ),
                                h12,
                                Text(
                                  'Minutes',
                                  style: landingPageBodyBold.copyWith(
                                    color: achromatic100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          w4,
                          Container(
                            color: achromatic500,
                            width: 2,
                            height: 112,
                          ),
                          w4,
                          Container(
                            constraints: const BoxConstraints(minWidth: 100),
                            child: Column(
                              children: [
                                Text(
                                  duration.inSeconds.remainder(60).toString(),
                                  style: landingPageHeading1.copyWith(
                                    color: primaryTealText,
                                  ),
                                ),
                                h12,
                                Text(
                                  'Seconds',
                                  style: landingPageBodyBold.copyWith(
                                    color: achromatic100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox(
                  width: maxWidth,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            duration.inDays.toString(),
                            style: landingPageHeading1.copyWith(
                              color: primaryTealText,
                            ),
                          ),
                          h12,
                          Text(
                            'Days',
                            style: landingPageBodyBold.copyWith(
                              color: achromatic100,
                            ),
                          ),
                        ],
                      ),
                      w4,
                      Container(
                        color: achromatic500,
                        width: 2,
                        height: 112,
                      ),
                      w4,
                      Column(
                        children: [
                          Text(
                            duration.inHours.remainder(24).toString(),
                            style: landingPageHeading1.copyWith(
                              color: primaryTealText,
                            ),
                          ),
                          h12,
                          Text(
                            'Hours',
                            style: landingPageBodyBold.copyWith(
                              color: achromatic100,
                            ),
                          ),
                        ],
                      ),
                      w4,
                      Container(
                        color: achromatic500,
                        width: 2,
                        height: 112,
                      ),
                      w4,
                      Column(
                        children: [
                          Text(
                            duration.inMinutes.remainder(60).toString(),
                            style: landingPageHeading1.copyWith(
                              color: primaryTealText,
                            ),
                          ),
                          h12,
                          Text(
                            'Minutes',
                            style: landingPageBodyBold.copyWith(
                              color: achromatic100,
                            ),
                          ),
                        ],
                      ),
                      w4,
                      Container(
                        color: achromatic500,
                        width: 2,
                        height: 112,
                      ),
                      w4,
                      Column(
                        children: [
                          Text(
                            duration.inSeconds.remainder(60).toString(),
                            style: landingPageHeading1.copyWith(
                              color: primaryTealText,
                            ),
                          ),
                          h12,
                          Text(
                            'Seconds',
                            style: landingPageBodyBold.copyWith(
                              color: achromatic100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
            interval: const Duration(seconds: 1),
            onFinished: () {},
          ),
          isSmallScreen ? h32 : h96,
        ],
      ),
    );
  }

  Padding _buildCompanyWidget(double maxWidth, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 32 : 112),
      child: SizedBox(
        width: maxWidth,
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          runSpacing: 12,
          children: [
            Assets.images.apexLegendsAsset.image(height: 128),
            Assets.images.callOfDutyAsset.image(height: 128),
            Assets.images.fortniteAsset.image(height: 128),
            Assets.images.rocketLeagueAsset.image(height: 128),
          ],
        ),
      ),
    );
  }

  Container _buildFeaturesWidget(double maxWidth, isSmallScreen) {
    return Container(
      color: achromatic800,
      padding: EdgeInsets.symmetric(
        horizontal: maxWidth > 900 ? 112 : 32,
      ),
      child: Column(
        children: [
          isSmallScreen ? h32 : h96,
          Text(
            'Features',
            style: landingPageOverlineBold.copyWith(
              color: primaryTealText,
            ),
          ),
          h12,
          Text(
            'How it works',
            style: landingPageHeading2.copyWith(color: achromatic100),
          ),
          h20,
          Container(
            constraints: BoxConstraints(
              maxWidth: 768,
              minWidth: maxWidth * 0.5,
            ),
            child: AutoSizeText(
              'Welcome to TM8! Create your profile, share your gaming preferences, and input your console gamertag. Our advanced matchmaking finds teammates who share your interests and skill level. Connect across all platforms, chat with matches, and jump into games together. Say goodbye to randoms and hello to your ultimate team with TM8!',
              style: landingPageBodyRegular.copyWith(color: achromatic200),
              textAlign: TextAlign.center,
              maxFontSize: isSmallScreen ? 16 : 20,
              minFontSize: 14,
            ),
          ),
          isSmallScreen ? h32 : h96,
          _buildFeature(
            featureName: 'Profile',
            featureTitle: 'Create your profile',
            featureDescription:
                'To get started with TM8, simply create your profile and tell us a bit about yourself and your gaming preferences. Input your gamertag for your console and our advanced matchmaking technology will use this information to find the perfect teammates for you. TM8 uses all gaming platforms and will be available on for iphone, android and google play.',
            placement: false,
            maxWidth: maxWidth,
            isSmallScreen: isSmallScreen,
            asset: Assets.images.tm8LoginAssetPortrait.path,
          ),
          isSmallScreen ? h32 : h96,
          _buildFeature(
            featureName: 'MatchMake',
            featureTitle: 'Match with your teammates',
            featureDescription:
                'Once you’ve created your profile, TM8 will start matching you with other players who share your gaming interests and skill level. You will be able to text and chat with your matches. You will also be able to see if your match is playing right now! With TM8, you can finally say goodbye to the frustration of playing with randoms and find your ultimate team.',
            placement: isSmallScreen ? false : true,
            maxWidth: maxWidth,
            isSmallScreen: isSmallScreen,
            asset: Assets.images.tm8MatchingAssetPortrait.path,
          ),
          h96,
        ],
      ),
    );
  }

  SizedBox _buildFeature({
    required featureName,
    required featureDescription,
    required featureTitle,
    required bool placement,
    required double maxWidth,
    required bool isSmallScreen,
    required String asset,
  }) {
    return SizedBox(
      width: maxWidth,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (placement) ...[
            Container(
              constraints: const BoxConstraints(
                maxWidth: 313,
                maxHeight: 512,
              ),
              child: Image.asset(
                asset,
                width: 313,
                height: 512,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                featureName,
                style: landingPageOverlineBold.copyWith(
                  color: primaryTealText,
                ),
              ),
              h8,
              Text(
                featureTitle,
                style: landingPageHeading3,
              ),
              h16,
              Container(
                constraints: const BoxConstraints(maxWidth: 624),
                child: AutoSizeText(
                  featureDescription,
                  style: landingPageBodyRegular.copyWith(
                    color: achromatic200,
                  ),
                  textAlign: TextAlign.justify,
                  maxFontSize: isSmallScreen ? 16 : 20,
                  minFontSize: 14,
                ),
              ),
            ],
          ),
          if (!placement) ...[
            if (isSmallScreen) ...[
              Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 313,
                    maxHeight: 512,
                  ),
                  child: Image.asset(
                    asset,
                    width: 313,
                    height: 512,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ] else
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 313,
                  maxHeight: 512,
                ),
                child: Image.asset(
                  asset,
                  width: 313,
                  height: 512,
                  fit: BoxFit.fitHeight,
                ),
              ),
          ],
        ],
      ),
    );
  }

  Padding _buildIntroHomeWidget(maxWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: maxWidth > 900 ? 112 : 32,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        runSpacing: 20,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'TM8 Never Lose',
                    style: landingPageHeading1.copyWith(color: achromatic100),
                  ),
                ),
                h24,
                FittedBox(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                    ),
                    child: AutoSizeText(
                      'The newest matchmaking technology to give you the advantage in the video game world!',
                      style:
                          landingPageBodyRegular.copyWith(color: achromatic200),
                      minFontSize: 18,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                if (maxWidth > 1000) ...[
                  h24,
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SvgPicture.asset(Assets.images.appleButton.path),
                      SvgPicture.asset(Assets.images.googleButton.path),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Stack(
            children: [
              Image.asset(
                Assets.images.tm8PreferencesAssetPortrait.path,
                width: maxWidth > 900 ? 240 : 138,
                height: maxWidth > 900 ? 500 : 286,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: maxWidth > 900
                    ? const EdgeInsets.only(left: 150, top: 80)
                    : const EdgeInsets.only(left: 100, top: 53),
                child: Image.asset(
                  Assets.images.tm8SelectGamesAssetPortrait.path,
                  width: maxWidth > 900 ? 240 : 138,
                  height: maxWidth > 900 ? 500 : 286,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          if (maxWidth < 1000) ...[
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SvgPicture.asset(Assets.images.appleButton.path),
                SvgPicture.asset(Assets.images.googleButton.path),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
