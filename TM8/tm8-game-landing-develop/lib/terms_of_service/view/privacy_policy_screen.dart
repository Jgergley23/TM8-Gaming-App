import 'package:anchor_scroll_controller/anchor_scroll_controller.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tm8l/app/constants/constants.dart';
import 'package:tm8l/app/constants/fonts.dart';
import 'package:tm8l/app/constants/palette.dart';
import 'package:tm8l/app/constants/routing_names.dart';
import 'package:tm8l/landing_page/widgets/landing_page_footer_widget.dart';
import 'package:tm8l/landing_page/widgets/landing_page_navbar_widget.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late final AnchorScrollController _scrollController;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    _scrollController = AnchorScrollController(
      onIndexChanged: (index, value) {},
    );

    _scrollController.addListener(() {
      setState(() {
        isVisible = _scrollController.offset > 400;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isVisible
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              foregroundColor: achromatic100,
              backgroundColor: primaryTeal,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
      body: LayoutBuilder(
        builder: (context, constrains) {
          final maxWidth = constrains.maxWidth;
          final isSmallScreen = maxWidth < 768;
          return Column(
            children: [
              LandingPageNavBarWidget(
                onPressed: (value) {
                  if (value == 0) {
                    context.beamToNamed(home, data: value);
                  } else if (value == 1) {
                    context.beamToNamed(about, data: value);
                  } else {
                    context.beamToNamed(contact, data: value);
                  }
                },
                page: 4,
              ),
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  children: [
                    _buildTOSPolicy(maxWidth, isSmallScreen),
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Container _buildTOSPolicy(
    double maxWidth,
    bool isSmallScreen,
  ) {
    return Container(
      color: achromatic800,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 60 : 232,
      ),
      child: Column(
        children: [
          isSmallScreen ? h32 : h96,
          Wrap(
            spacing: 40,
            runSpacing: 28,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'TM8 GAMING LLC PRIVACY POLICY',
                    style: landingPageHeading2.copyWith(color: achromatic100),
                  ),
                  h20,
                  Text(
                    'Effective: July 2024',
                    style:
                        landingPageBodyRegular.copyWith(color: achromatic200),
                  ),
                  Text(
                    'Last updated: July 2024',
                    style:
                        landingPageBodyRegular.copyWith(color: achromatic200),
                  ),
                  h40,
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 800,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'TM8 Gaming LLC (',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: '“TM8”, “we,” “us,” or “our”',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ') values your privacy. In this Privacy Policy ("',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Policy',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '), we describe how we collect, use, and disclose information we obtain about visitors to our website, ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'https://tm8gaming.com/',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.beamToNamed(
                                      home,
                                      data: null,
                                    );
                                  },
                              ),
                              TextSpan(
                                text: ' (the "',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Website',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '") , users of our mobile application (the “',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'App',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '"), and services available through our Website and App (the “',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Services',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '"), visitors to our social media sites, communications with TM8, and other online offerings, and how we use and disclose that information.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'By visiting the Website, using or downloading the App, or using any of our Services, you acknowledge that your personal information will be handled as described in this Policy. Your use of our Website, App, or Services, and any dispute over privacy, is subject to this Policy and our ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ', including its applicable limitations on damages and the resolution of disputes. The Terms & Conditions are incorporated by reference into this Policy.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          '1) THE INFORMATION WE COLLECT ABOUT YOU',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          'We collect information about you directly from you and from other parties, as well'
                          'as automatically through your use of our Website and App. The information we'
                          'collect from you depends on how you use our Website, App, and Services.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'To Create an Account Online or Through the App.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Creating an account online or through the App allows you to play games independently or be matched with other users using our AI-driven personalized matchmaking technology for the purpose of playing competitive or casual games, interact with our community platform, participate in in-game voice chats, and participate in in-app text messaging.To create an account, you must provide us with your name, physical address, email address, date of birth, phone number, payment and billing information, and username and password. ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Information We Collect from Social Networking Websites.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'If you log into your online account or our Apps through a social networking website, we store the information we receive from the social networking website with other information that we collect from you or receive about you in accordance with this Policy. Any social networking website controls the information it collects from you pursuant to its own terms. For information about how a social networking website may use and disclose the information it collects about you, including any information you make public through the social networking website, please consult the social network’s privacy policy. We have no control over how any social networking websites use or disclose the personal information they collect about you.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '‍We also collect information about you when you interact with us on social'
                                  'networking platforms. If you message us or tag us in a social network'
                                  'post, we will collect information about your message or the post we are'
                                  'tagged in.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Information We Collect Automatically.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'We automatically collect information about your use of our Website and Apps and your purchase transactions through cookies, web beacons, and other tracking technologies, including technologies designed for mobile apps. To the extent permitted by applicable law, we combine this information with other information we collect about you, including your personal information. Please see the section “Cookies and Other Tracking Mechanisms” below for more information.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Text(
                          'Website:',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'domain name; your browser type and operating system; web pages you view on the Website; links you click on the Website; your IP address; the length of time you visit our Website and or use our Services; the referring URL, or the webpage that led you to our Website; and your device’s location information, with your permission, to help us market TM8’s services.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Text(
                          'App:',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'mobile device ID; device name and model; operating system type, name, and version; language information; activities within the App; and the length of time that you are logged into our App; location information. With your permission, we will collect location information from your mobile device to help us market the TM8 services. You may turn off this feature through the location settings on your mobile device.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h20,
                        Text(
                          '2) HOW WE USE YOUR INFORMATION',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          'We use your information, including your personal information, for the following'
                          'purposes:',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'To provide our services to you, to communicate with you about your use of our'
                                  'services, and for other customer service purposes.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'To tailor the content and information we may send or display to you, and to'
                                  'otherwise personalize your experiences while using the Website and App.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'For marketing and promotional purposes in accordance with applicable laws. For'
                                  'example, we may use your information, such as your email address, to send you'
                                  'news and newsletters, special offers and promotions, or to otherwise contact you'
                                  'about products, services, or other information we think may interest you.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'We use your information (typically in the aggregate) to assist us in advertising the'
                                  'TM8 brand on unaffiliated websites and in evaluating the success of our'
                                  'advertising campaigns (including our online targeted advertising and offline'
                                  'promotional campaigns).',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'To better understand how users access and use our Website and Apps, both on'
                                  'an aggregated and individualized basis, in order to improve our Website and'
                                  'Apps and respond to user desires and preferences, and for other research and'
                                  'analytical purposes.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'To administer member contests, challenges, and incentive programs.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'To administer surveys and questionnaires, such as for market research or'
                                  'member satisfaction purposes.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'To comply with legal and regulatory obligations, as part of our general business'
                                  'operations, and for other business administration purposes, including'
                                  'authenticating your identity, maintaining customer records, to monitor your'
                                  'compliance with any of your agreements with us, to collect debts owed to us, to'
                                  'safeguard our business interests, and to manage or transfer our assets or'
                                  'liabilities, such as in the case of an acquisition, disposition or merger, as'
                                  'described below.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Where we believe necessary to investigate, prevent or take action regarding'
                                  'illegal activities, suspected fraud or error, situations involving potential threats to'
                                  'the safety of any person, or violations of our Terms & Conditions or this Privacy'
                                  'Policy.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'To process payment for products or services purchased.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'For other purposes that we may inform you about from time to time.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h20,
                        Text(
                          '3) HOW WE SHARE YOUR INFORMATION',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          'We may share your personal information pursuant to the following circumstances:',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'As Part of a Legal Process.',
                                        style: body1Regular.copyWith(
                                          color: achromatic300,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' We may disclose the information we collect from you in order to comply with the law, a judicial proceeding, or other legal process, such as in response to a court order or a subpoena.',
                                        style: body1Regular.copyWith(
                                          color: achromatic300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'To Protect Us and Others.',
                                        style: body1Regular.copyWith(
                                          color: achromatic300,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'We also may disclose the information we collect from you where we believe it is necessary to investigate, prevent, or take action regarding illegal activities, suspected fraud, situations involving potential threats to the safety of any person, violations of our ',
                                        style: body1Regular.copyWith(
                                          color: achromatic300,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Terms & Conditions',
                                        style: body1Regular.copyWith(
                                          color: achromatic100,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' or this Policy, or where it is reasonably necessary as evidence in litigation in which TM8 is involved.',
                                        style: body1Regular.copyWith(
                                          color: achromatic100,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Aggregate and De-Identified Information.',
                                        style: body1Regular.copyWith(
                                          color: achromatic300,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' We may share aggregate, de-identified, or anonymized information about users and members with others for marketing, advertising, research, or similar purposes without your consent.',
                                        style: body1Regular.copyWith(
                                          color: achromatic300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h20,
                        Text(
                          '4) OUR USE OF COOKIES AND OTHER TRACKING MECHANISMS',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          'We and our service providers use cookies and other tracking mechanisms to'
                          'track information about your use of our Website and App. We may combine this'
                          'information with other personal information we collect from you (and our service'
                          'providers may do so on our behalf).',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '‍Cookies.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' Cookies are alphanumeric identifiers that we transfer to your computer’s hard drive through your web browser for record-keeping purposes. Some cookies allow us to make it easier for you to navigate our Website and App, while others are used to enable a faster log-in process or to allow us to track your activities at our Website and App. However, we do not track cookies on the landing page of the Website.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '‍‍Disabling Cookies.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' Cookies are alphanumeric identifiers that we transfer to your computer’s hard drive through your web browser for record-keeping purposes. Some cookies allow us to make it easier for you to navigate our Website and App, while others are used to enable a faster log-in process or to allow us to track your activities at our Website and App. However, we do not track cookies on the landing page of the Website.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '‍‍‍Clear GIFs, Pixel Tags and Other Technologies.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' Clear GIFs are tiny graphics with a unique identifier, similar in function to cookies. In contrast to cookies, which are stored on your computer’s hard drive, clear GIFs are embedded invisibly on web or mobile application pages. We may use clear GIFs (aka web beacons, web bugs or pixel tags), in connection with our Website and App to, among other things, track the activities of Website visitors and App users, help us manage content, and compile statistics about usage of our Website and Apps. We and our service providers also use clear GIFs in HTML emails to our customers to help us track email response rates, identify when our emails are viewed, and track whether our emails are forwarded.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '‍Analytics.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' We use automated devices and applications, such as Adobe Analytics and Google Analytics, to evaluate usage of our Website, and to the extent permitted, our Apps. We also may use other analytic means to evaluate our Website and Apps. We use these tools to help us improve our Website’s and Apps’ performance and user experiences. These entities may use cookies and other tracking technologies, such as web beacons or local storage objects (LSOs), to perform their services. To learn more about Adobe Analytics and Google Analytics and about your options for opting out, please visit their respective websites. ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '‍Do Not Track Requests.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Currently, our systems do not recognize browser “do-not-track” requests. ',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'You may, however, disable certain tracking as discussed in this section (e.g., by disabling cookies). ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          '5) SECURITY OF YOUR PERSONAL INFORMATION',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        h20,
                        Text(
                          'We have implemented reasonable precautions to protect the information we'
                          'collect from loss, misuse, and unauthorized access, disclosure, alteration, and'
                          'destruction, such as data encryption, access controls, and use of secure servers.'
                          'Please be aware that despite our efforts, no data security measures can'
                          'guarantee security.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Text(
                          'You should take steps to protect against unauthorized access to your password,'
                          'phone, and computer by, among other things, signing off after using a shared'
                          'computer, choosing a robust password that nobody else knows or can easily'
                          'guess, and keeping your log-in and password private. We are not responsible for'
                          'any lost, stolen, or compromised passwords or for any activity on your account'
                          'via unauthorized password activity.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          '6) ACCESS TO YOUR PERSONAL INFORMATION',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        h20,
                        Text(
                          'You may access your personal information at any time by logging into your'
                          'account, emailing TM8, or contacting customer support. You may modify and'
                          'delete personal information that you have submitted by logging into your account'
                          'and updating your profile information or deleting your information or account.'
                          'Please note that copies of information that you have updated, modified, or'
                          'deleted may remain viewable in cached and archived pages of the Website or'
                          'App for a period of time.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          '7) WHAT CHOICES DO I HAVE REGARDING PROMOTIONAL EMAILS?',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        h20,
                        Text(
                          'In accordance with applicable law, we will send periodic promotional'
                          'communications to you. You may opt out of such communications by following'
                          'the opt-out instructions contained in the communication. We will process opt-out'
                          'requests in accordance with applicable law. If you opt out of receiving'
                          'promotional communications about recommendations or other information we'
                          'think may interest you, we may still send you communications about your'
                          'account or any services you have requested or received from us. App users may'
                          'enable or disable push notifications by adjusting their App or device settings.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          '8) CHILDREN UNDER 13',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        h20,
                        Text(
                          'Our Website, Apps, and services are not designed for children under the age of'
                          '13. If we discover that a child under the age of 13 has provided us with personal'
                          'information, we will delete such information from our systems.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          '9) CHILDREN BETWEEN THE AGES OF 13 AND 17',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        h20,
                        Text(
                          'Children between the ages of 13 and 17 will have access to a feature that matches them exclusively with other users within this same age group. By using this feature, you acknowledge that TM8 is not responsible for any instances where users provide false age or date of birth information. However, we take these situations very seriously and will, upon request, attempt to verify this information to the best of our ability. We encourage parents and guardians to monitor their children’s online activities and ensure the accuracy of the information provided. Personal information for this age group is collected and stored in the same manner as all other personal information covered by this Policy.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          '10) CHANGES TO THIS POLICY',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        h20,
                        Text(
                          'This Policy is current. We may change this Policy from time to time, so please be'
                          'sure to check back periodically. We will post any changes to this Policy on our'
                          'Website and App. If we make any changes to this Policy that materially affect our'
                          'practices regarding the personal information we have previously collected from'
                          'you, we will endeavor to provide you with notice in advance of such change by'
                          'highlighting the change on our Website and App.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          '11) CALIFORNIA RESIDENTS',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        h20,
                        Text(
                          'California law grants California residents certain rights and imposes restrictions'
                          'on particular business practices as set forth below:',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Notice Before Collection.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' We are required to notify California residents, at or before the point of collection of their personal information, the categories of personal information collected and the purposes for which such information is used.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Request to Delete.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' California residents have the right to request, at no charge, deletion of their personal information that we have collected about them and to have such personal information deleted, except where an exemption applies. We will respond to verifiable requests received from California residents as required by law.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Request to Know.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' California residents have the right to request and, subject to certain exemptions, receive a copy of the specific pieces of personal information that we have collected about them in the prior 12 months and to have this delivered, free of charge, either (a) by mail or (b) electronically in a portable and, to the extent technically feasible, a readily useable format that allows the individual to transmit this information to another entity without hindrance. California residents also have the right to request that we provide them certain information about how we have handled their personal information in the prior 12 months, including categories of personal information collected; categories of sources of personal information; business and/or commercial purposes for collecting and selling their personal information; categories of third parties/with whom we have disclosed or shared their personal information; categories of personal information that we have disclosed or shared with a third party for a business purpose; and categories of third parties to whom the residents’ personal information has been sold and the specific categories of personal information sold to each category of third party.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Do-Not-Sell (Opt-Out/Opt-In).',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' California residents have the right to opt-out of our sale of their personal information. Further, businesses may not knowingly sell personal information about minors under 16 years old without prior express consent.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Authorized Representatives.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' You may also designate an authorized representative to make consumer rights requests on your behalf. We will require verification that you did in fact authorize the representative.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Discrimination and Financial Incentives.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' The California Consumer Privacy Act of 2018 (“CCPA”) prohibits discrimination against California residents for exercising their rights under the CCPA. A business may offer financial incentives for the collection, sale, or deletion of California residents’ personal information, where the incentive is not unjust, unreasonable, coercive, or usurious, and is made available in compliance with applicable transparency, informed consent, and opt-out requirements. California residents have the right to be notified of any financial incentives offers and their material terms, the right to opt-out of such incentives at any time, and may not be included in such incentives without their prior informed opt-in consent. TM8 does not offer any such incentives at this time.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Text(
                          'California residents may submit a request to know or a request to delete to us by'
                          'emailing us at jgergley@tm8gaming.com. We may require additional information'
                          'from you in order to verify your request. We will respond to verifiable requests'
                          'received from California residents as required by law. If you have a disability, you'
                          'may request a copy of this Privacy Policy or any other required accommodation'
                          'be provided to you by contacting us. You may also submit your request by postal'
                          'mail to: TM8 Gaming LLC Attn: Legal Department, 622 NW 3RD Ave APT 1,'
                          'Gainesville, FL, 32601-5722. We will make every effort to promptly respond to'
                          'your request.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          '12) OPT-IN COMPLIANCE',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        h20,
                        Text(
                          'To ensure compliance with Twilio Messaging Policy and other applicable regulations, TM8 Gaming LLC ("TM8") follows strict guidelines regarding opt-in for communications through our services. We are committed to transparency and responsible handling of user data in line with the following practices:',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1.',
                              style: body1Regular.copyWith(
                                color: achromatic300,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Detailing All Opt-in Methods: ',
                                      style: body1Regular.copyWith(
                                        color: achromatic300,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      'TM8 provides multiple ways for users to opt-in to receiving communications, including but not limited to:',
                                      style: body1Regular.copyWith(
                                        color: achromatic300,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Electronic opt-in: Users can opt-in by entering their information on our Website or App.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'In-person or verbal opt-in: For specific events, users may provide their consent in person or through verbal confirmation. Verbal opt-ins will be documented and verified for compliance.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${String.fromCharCode(0x2022)} ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Paper form opt-in: In rare cases, paper forms may be used, and TM8 will securely retain copies of the signed forms.',
                                  style: body1Regular.copyWith(
                                    color: achromatic300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '2.',
                              style: body1Regular.copyWith(
                                color: achromatic300,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Providing Necessary Links and Documentation:',
                                      style: body1Regular.copyWith(
                                        color: achromatic300,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    Text(
                                      'Where opt-in is collected via non-digital means, such as paper forms or in-person verbal agreements, TM8 ensures that a hosted link to an image of the opt-in is available upon request. If the opt-in occurs through the Website or App, relevant links to the form or opt-in process will be made available to users for verification.',
                                      style: body1Regular.copyWith(
                                        color: achromatic300,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3.',
                              style: body1Regular.copyWith(
                                color: achromatic300,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Inclusion of Privacy Policy and Terms of Service:',
                                      style: body1Regular.copyWith(
                                        color: achromatic300,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    Text(
                                      'All digital opt-in processes are accompanied by clear access to our Privacy Policy and Terms of Service, ensuring that users are fully informed of how their data will be used before providing consent.',
                                      style: body1Regular.copyWith(
                                        color: achromatic300,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '4.',
                              style: body1Regular.copyWith(
                                color: achromatic300,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Avoidance of Third-Party Sharing:',
                                      style: body1Regular.copyWith(
                                        color: achromatic300,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    Text(
                                      'TM8 does not share user opt-in information with any unauthorized third parties. We ensure that all data collected for communication purposes is kept secure and used solely for the purposes stated at the time of opt-in.',
                                      style: body1Regular.copyWith(
                                        color: achromatic300,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '5.',
                              style: body1Regular.copyWith(
                                color: achromatic300,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Verification of Opt-in:',
                                      style: body1Regular.copyWith(
                                        color: achromatic300,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    Text(
                                      'TM8 manually reviews each campaign to ensure that the opt-in process is verifiable. Each opt-in must be clear, documented, and traceable to ensure full compliance with applicable laws. In case of any doubt or audit, the verification process can be demonstrated to relevant authorities.',
                                      style: body1Regular.copyWith(
                                        color: achromatic300,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        h10,
                        Text(
                          'These measures help us to stay compliant with relevant laws and protect the rights of our users while ensuring they receive the information and services they’ve opted into. TM8 reserves the right to update its opt-in practices as needed to maintain compliance with regulatory changes.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        Text(
                          '13) CONTACT US',
                          style: heading3Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        h20,
                        Text(
                          'If you have questions about the privacy aspects of our Services or would like to'
                          'make a complaint, please contact us at jgergley@tm8gaming.com (type “Privacy”'
                          'in the subject line).',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                      ],
                    ),
                  ),
                  isSmallScreen ? h32 : h96,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
