import 'package:auto_size_text/auto_size_text.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8l/app/constants/constants.dart';
import 'package:tm8l/app/constants/fonts.dart';
import 'package:tm8l/app/constants/palette.dart';
import 'package:tm8l/app/constants/routing_names.dart';
import 'package:tm8l/app/services/service_locator.dart';
import 'package:tm8l/gen/assets.gen.dart';
import 'package:tm8l/landing_page/logic/faq_cubit/faq_controller_cubit.dart';
import 'package:tm8l/landing_page/widgets/landing_page_button_widget.dart';
import 'package:tm8l/landing_page/widgets/landing_page_footer_widget.dart';

class AboutPageScreen extends StatefulWidget {
  const AboutPageScreen({super.key});

  @override
  State<AboutPageScreen> createState() => _AboutPageScreenState();
}

class _AboutPageScreenState extends State<AboutPageScreen> {
  final listQuestion = [
    'What is the purpose of this gaming matchmaking app?',
    'Are your games available in different languages?',
    'How does the matchmaking process work for gaming?',
    'What games are available to be matched?',
    'Can I communicate with other players through the app?',
    'Is my personal information safe on the app?',
    'What if I encounter technical issues or need help using the app?',
  ];

  final listAnswers = [
    'Tm8 is designed to connect gamers looking for like minded players to team up and play together in various multiplayer games. It aims to facilitate enjoyable gaming experiences and foster a community of players with shared gaming interests.',
    'Our app will be available in different languages. Please check the game details for specific language options.',
    'The matchmaking process involves gamers creating profiles that include their gaming preferences, favorite games, skill level, and availability. The app then uses algorithms to match players based on these criteria, helping them find suitable teammates or opponents. ',
    'As of right now the main games are Fortnite, Rocket League, Apex and Call of Duty. We started with these four games to help matchmaking be more efficient. In future updates the app will expand giving users more game options. Our goal is to have every multiplayer game on the app. ',
    'Yes, our app provides in-app messaging and voice chat features to facilitate communication between players, allowing them to coordinate and strategize before, during and after gameplay.',
    'Yes, reputable gaming matchmaking apps prioritize user privacy and data security. They employ encryption and adhere to strict privacy policies to protect personal information from unauthorized access or misuse.',
    "If you encounter any technical issues while using the app or need assistance, you can reach out to the app's customer support team for prompt resolution.",
  ];
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FaqControllerCubit>(),
      child: LayoutBuilder(
        builder: (context, constrains) {
          final maxWidth = constrains.maxWidth;
          final isSmallScreen = maxWidth < 768;
          return ListView(
            children: [
              isSmallScreen ? h32 : h96,
              _buildAboutUsInfoWidget(isSmallScreen),
              isSmallScreen ? h32 : h96,
              _buildGoalWidget(maxWidth, isSmallScreen),
              // isSmallScreen ? h32 : h96,
              // _buildOurTeamWidget(maxWidth, isSmallScreen),
              isSmallScreen ? h32 : h96,
              _buildFrequentlyAskedQuestions(maxWidth, isSmallScreen),
              isSmallScreen ? h32 : h96,
              LandingPageFooterWidget(
                onPressed: (value) {
                  if (value == 0) {
                    context.beamToNamed(home, data: value);
                  } else if (value == 1) {
                    context.beamToNamed(about, data: value);
                  } else {
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

  Container _buildFrequentlyAskedQuestions(
    double maxWidth,
    bool isSmallScreen,
  ) {
    return Container(
      color: achromatic800,
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 32 : 112),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isSmallScreen ? h32 : h96,
          AutoSizeText(
            'Frequently asked questions',
            style: landingPageHeading2.copyWith(color: achromatic100),
            textAlign: TextAlign.center,
            maxFontSize: isSmallScreen ? 28 : 36,
            minFontSize: 26,
          ),
          h20,
          AutoSizeText(
            'Please reach us if you cannot find an answer to your question.',
            style: landingPageBodyRegular.copyWith(
              color: achromatic200,
            ),
            textAlign: TextAlign.justify,
            maxFontSize: isSmallScreen ? 16 : 20,
            minFontSize: 14,
          ),
          isSmallScreen ? h20 : h64,
          BlocBuilder<FaqControllerCubit, List<bool>>(
            builder: (context, state) {
              return Container(
                padding:
                    EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 32),
                constraints: const BoxConstraints(maxWidth: 768),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < state.length; i++) ...[
                      InkWell(
                        onTap: () {
                          context.read<FaqControllerCubit>().update(i);
                        },
                        child: SizedBox(
                          width: maxWidth,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset(
                                  state[i]
                                      ? Assets.images.navigationUp.path
                                      : Assets.images.navigationDown.path,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      listQuestion[i],
                                      style: landingPageBodyRegular.copyWith(
                                        color: achromatic100,
                                      ),
                                      maxFontSize: isSmallScreen ? 16 : 20,
                                      minFontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!state[i]) ...[
                        h32,
                        Container(
                          height: 2,
                          color: achromatic500,
                        ),
                        h32,
                      ],
                      if (state[i]) ...[
                        h8,
                        Text(
                          listAnswers[i],
                          style: landingPageOverlineRegular.copyWith(
                            color: achromatic200,
                          ),
                        ),
                        h32,
                        Container(
                          height: 2,
                          color: achromatic500,
                        ),
                        h32,
                      ],
                    ],
                  ],
                ),
              );
            },
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
        // color: achromatic600,
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

  // Padding _buildOurTeamWidget(double maxWidth, bool isSmallScreen) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 32 : 112),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           'Who are we?',
  //           style: landingPageOverlineBold.copyWith(color: primaryTealText),
  //           textAlign: TextAlign.center,
  //         ),
  //         h12,
  //         Text(
  //           'Meet our team',
  //           style: landingPageHeading2.copyWith(color: achromatic100),
  //           textAlign: TextAlign.center,
  //         ),
  //         h20,
  //         Container(
  //           constraints: const BoxConstraints(maxWidth: 768),
  //           child: AutoSizeText(
  //             'Our team is made up of passionate employees that want your gaming experience to be the best it can be. We are always here to help and answer any questions you may have.',
  //             style: landingPageBodyRegular.copyWith(color: achromatic200),
  //             textAlign: TextAlign.justify,
  //             maxFontSize: isSmallScreen ? 16 : 20,
  //             minFontSize: 14,
  //           ),
  //         ),
  //         isSmallScreen ? h20 : h64,
  //         SizedBox(
  //           width: maxWidth,
  //           child: isSmallScreen
  //               ? SizedBox(
  //                   height: 300,
  //                   child: PageView(
  //                     scrollDirection: Axis.horizontal,
  //                     controller: pageController,
  //                     children: [
  //                       for (var i = 0; i < 8; i++) ...[
  //                         _teamMemberWidget(isSmallScreen),
  //                       ],
  //                     ],
  //                   ),
  //                 )
  //               : Wrap(
  //                   runSpacing: isSmallScreen ? 32 : 64,
  //                   spacing: 32,
  //                   children: [
  //                     for (var i = 0; i < 8; i++)
  //                       _teamMemberWidget(isSmallScreen),
  //                   ],
  //                 ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Container _teamMemberWidget(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: achromatic800,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            Assets.images.teamAvatar.path,
            width: 64,
            height: 64,
          ),
          h20,
          Text(
            'Jane Doe',
            style: landingPageName.copyWith(color: achromatic100),
            textAlign: TextAlign.center,
          ),
          Text(
            'Role',
            style: landingPageOverlineRegular.copyWith(color: primaryTealText),
            textAlign: TextAlign.center,
          ),
          h8,
          Container(
            constraints: const BoxConstraints(maxWidth: 232),
            child: AutoSizeText(
              'Lorem ipsum dolor sit amet consectetur. Pharetra neque molestie sit nibh eget nec nisl.',
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
    );
  }

  Container _buildGoalWidget(double maxWidth, bool isSmallScreen) {
    return Container(
      color: achromatic800,
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 32 : 112),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSmallScreen ? h32 : h96,
          _buildGoalItem(
            maxWidth,
            'Our goal',
            'At TM8, we recognize the challenges that can arise when teammates are not aligned in skill level or commitment, impacting the overall gaming experience. Our mission is to elevate the gaming community by fostering connections among like-minded individuals who share similar gaming preferences and aspirations. Through our platform, we aim to curate optimal gaming groups, ensuring compatibility in skill levels and dedication to enhance the overall gameplay experience. TM8 is committed to creating a space where players can collaborate seamlessly, minimizing frustrations associated with uneven teamwork and maximizing the potential for victories. Join us for the ultimate gaming experience, where teamwork and shared goals converge for unparalleled success.',
            false,
            isSmallScreen,
            Assets.images.goal.path,
          ),
          isSmallScreen ? h20 : h64,
          _buildGoalItem(
            maxWidth,
            'Our mission',
            'At TM8 Gaming our mission is to enhance the gaming experience by connecting players with their perfect teammates. Every gamer has had that random teammate that goes AFK, quits the game or just isn’t at your skill level. We are here to change that narrative and help you connect with real users in real time to create the best gaming experience and get you winning more games. Through AI-driven matchmaking, we empower gamers to win more games and enjoy a better gaming experience, fostering a community of camaraderie and success. ',
            true,
            isSmallScreen,
            Assets.images.mission.path,
          ),
          isSmallScreen ? h20 : h64,
          _buildGoalItem(
            maxWidth,
            'Our history',
            'Founded in 2023, TM8 has been in development for a year now to make sure that our algorithm for finding teammates is the best we can offer. Using top notch developers in both software and Ai has brought us to this point and we can’t wait to share TM8 with the world.',
            false,
            isSmallScreen,
            Assets.images.history.path,
          ),
          isSmallScreen ? h32 : h96,
        ],
      ),
    );
  }

  SizedBox _buildGoalItem(
    double maxWidth,
    String title,
    String description,
    bool placement,
    bool isSmallScreen,
    imageName,
  ) {
    return SizedBox(
      width: maxWidth,
      child: Wrap(
        runSpacing: 20,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (placement && !isSmallScreen)
            Image.asset(
              imageName,
              width: 576,
              height: 512,
            ),
          if (!isSmallScreen) ...[
            Container(
              constraints: const BoxConstraints(maxWidth: 544),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: landingPageHeading3.copyWith(color: achromatic100),
                  ),
                  h16,
                  AutoSizeText(
                    description,
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
          ],
          if (!placement && !isSmallScreen)
            Image.asset(
              imageName,
              width: 576,
              height: 512,
            ),
          if (isSmallScreen) ...[
            Container(
              constraints: const BoxConstraints(maxWidth: 544),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: landingPageHeading3.copyWith(color: achromatic100),
                  ),
                  h16,
                  AutoSizeText(
                    description,
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
        ],
      ),
    );
  }

  Padding _buildAboutUsInfoWidget(bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 32 : 112),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'All your questions answered',
            style: landingPageOverlineBold.copyWith(color: primaryTealText),
            textAlign: TextAlign.center,
          ),
          h12,
          Text(
            'Who are we?',
            style: landingPageHeading2.copyWith(color: achromatic100),
            textAlign: TextAlign.center,
          ),
          h12,
          AutoSizeText(
            'Find out about our goal, mission and history, and meet our team.',
            style: landingPageBodyRegular.copyWith(color: achromatic200),
            textAlign: TextAlign.center,
            maxFontSize: isSmallScreen ? 16 : 20,
            minFontSize: 14,
          ),
        ],
      ),
    );
  }
}
