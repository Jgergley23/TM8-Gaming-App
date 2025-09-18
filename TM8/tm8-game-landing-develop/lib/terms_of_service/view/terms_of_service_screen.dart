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

class TermsOfServiceScreen extends StatefulWidget {
  const TermsOfServiceScreen({super.key});

  @override
  State<TermsOfServiceScreen> createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
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
                    'TERMS & CONDITIONS OF TM8 GAMING LLC',
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
                        Text(
                          'PLEASE READ THESE TERMS & CONDITIONS CAREFULLY, AS THEY CONTAIN'
                          'IMPORTANT INFORMATION REGARDING YOUR LEGAL RIGHTS, REMEDIES AND'
                          'OBLIGATIONS. THESE INCLUDE VARIOUS LIMITATIONS AND EXCLUSIONS, AND'
                          'A DISPUTE RESOLUTION CLAUSE THAT GOVERNS HOW DISPUTES WILL BE'
                          'RESOLVED.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h20,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'The TM8 Gaming LLC ("',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'TM8',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '") App and Website allow users to receive information '
                                    'about TM8, and use the gaming services offered by TM8. The services offered by TM8 ("',
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
                                text: '") include but are not limited to the ',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'https://tm8gaming.com/ ',
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
                                text: 'Website ("',
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
                                    '"), which is hosted in the United States and the TM8 mobile application ("',
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
                                text: '"). These terms and conditions ("',
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
                                text: '") set forth the legally'
                                    'binding terms for your use of the TM8 Services. By using the TM8 Services, you agree'
                                    'to be bound by these Terms & Conditions, whether you are a "',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Visitor',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: '" (which means'
                                    'that you simply browse the Website or App) or you are a "',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Member',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: '" (which means that'
                                    'you have registered with TM8 and/or use or purchased one or more Services). The term "',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'User',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '" refers to a Visitor or a Member. You are only authorized to use the Services'
                                    '(regardless of whether your access or use is intended) if you agree to abide by all'
                                    'applicable laws and to these Terms & Conditions. Please read this Terms & Conditions'
                                    'notice carefully and save it. If you do not agree with it, you should leave the Website or '
                                    'the App and discontinue use of the Services immediately. If you wish to become a'
                                    'Member, you must read these Terms & Conditions and indicate your acceptance during'
                                    'the registration process.',
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
                          'GENERAL TERMS',
                          style: body1Regular.copyWith(
                            color: achromatic100,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        h20,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'YOUR ACCEPTANCE: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'By using and/or visiting this Website or using the App, you'
                                    'signify your agreement to these Terms & Conditions, as well as TM8’s "',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '" (posted on the Website and/or incorporated herein by reference). If you do not agree to'
                                    'any of these terms or to any of the terms of the Privacy Policy, please do not use the'
                                    'TM8 Services. Although we may attempt to notify you when major changes are made to'
                                    'these Terms & Conditions, you should periodically review the most up to date version,'
                                    'which will always be posted on the Website and/or App.. TM8 may, at its sole discretion, modify or'
                                    'revise these Terms & Conditions, the Privacy Policy, and any of its other policies at any'
                                    'time, and you agree to be bound by such modifications or revisions. Nothing in these'
                                    'Terms & Conditions shall be deemed to confer any third-party rights or benefits.',
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
                                text: 'TM8 WEBSITE AND TM8 APP: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'These Terms & Conditions apply to all Users of the'
                                    'TM8 Website and the TM8 App. The Website and App may contain links to third party'
                                    'Websites that are not owned or controlled by TM8. TM8 has no control over, and'
                                    'assumes no responsibility for, the content, privacy policies, or practices of any third-'
                                    'party Websites, including privacy and data gathering practices. In addition, TM8 will not'
                                    'and cannot censor or edit the content of any third-party site. By using the Website, you'
                                    'expressly relieve and release TM8 from any and all liability arising from your use of any'
                                    'third-party Website. Accordingly, we encourage you to be aware when you leave the'
                                    'Website or App and to read the terms and conditions and privacy policy of each other'
                                    'Website that you visit. Upon leaving the TM8 Website or TM8 App these Terms &'
                                    'Conditions shall no longer govern.',
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
                                text: 'TM8 ACCOUNTS: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'In order to access some features of the Website and the App, you'
                                    'will have to create a TM8 account. You may not use another person’s account without'
                                    'permission. When creating your account, you must provide accurate and complete'
                                    'information. You are solely responsible for the activity that occurs on your account, and'
                                    'you must keep your account password secure. You must notify TM8 immediately of any'
                                    'breach of security or unauthorized use of your account. Although TM8 will not be liable'
                                    'for your losses caused by any unauthorized use of your account, you may be liable for'
                                    'the losses of TM8 or others due to such unauthorized use.',
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
                                text: 'ELIGIBILITY: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Membership is void where prohibited. This Website is intended solely for'
                                    'Users who are 13 years of age or older. Any registration by, use of, or access to the'
                                    'Website by anyone under 13 is unauthorized, unlicensed and in violation of these'
                                    'Terms & Conditions. By using the TM8 Services, you represent and warrant that you'
                                    'are 13 or older and that you agree to abide by all of the terms and conditions of these'
                                    'Terms & Conditions. Children between the ages of 13 and 17 will have access to a'
                                    'feature that matches them exclusively with other users within this same age group. By'
                                    'using this feature, you acknowledge that TM8 is not responsible for any instances'
                                    'where users provide false age or date of birth information. However, we take these'
                                    'situations very seriously and will, upon request, attempt to verify this information to the'
                                    'best of our ability. We encourage parents and guardians to monitor their children’s'
                                    'online activities and ensure the accuracy of the information provided. Personal'
                                    'information for this age group is collected and stored in the same manner as all other'
                                    'personal information covered by this Policy.',
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
                                text: 'TERM: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'These Terms & Conditions shall remain in full force and effect while you use the'
                                    'Services or are a Member. You may terminate your membership at any time, for any'
                                    'reason, by following the instructions in the App. TM8 may terminate your membership at'
                                    'any time, without warning, if you breach these Terms & Conditions. Even after'
                                    'membership is terminated, these Terms & Conditions will remain in effect.',
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
                                text: 'FEES: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'TM8 does not charge a fee for the free version of the Website or App that'
                                    'includes advertisements. However, you acknowledge that TM8 charges fees for certain'
                                    'subscription services, and TM8 reserves the right to change its fees from time to time at'
                                    'its discretion. If TM8 terminates your membership because you have breached these'
                                    'Terms & Conditions, you may not be entitled to a refund of any unused portion of your'
                                    'membership or other fees.',
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
                                text: 'Subscriptions: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'TM8 offers a free version of the Website and App which includes'
                                    'advertisements. You have the option to upgrade to a subscription version of the'
                                    'Website and App without advertisements, which requires a recurring fee. If you wish to'
                                    'cancel your subscription including the recurring fee, you may do so at any time, but'
                                    'there will be no refunds for fees already paid.',
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
                                text: 'PASSWORD: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'When you sign up to become a member, you will also be asked to'
                                    'choose a password. You are entirely responsible for maintaining the confidentiality of'
                                    'your password. You agree not to use the account, username, or password of another'
                                    'member at any time or to disclose your password to any third party. You agree to notify'
                                    'TM8 immediately if you suspect any unauthorized use of your account or access to your'
                                    'password. You are solely responsible for any and all use of your account.',
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
                                    'USE OF THE WEBSITE AND APP - PERMISSIONS AND RESTRICTIONS: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: 'TM8'
                                    'hereby grants you permission to access and use the Website and App as set forth in'
                                    'these Terms & Conditions, provided that you agree not to distribute in any medium any'
                                    'part of the Website or App, without TM8’s prior written authorization and you agree not'
                                    'to alter or modify any part of the Website, the App, or any of their related technologies.'
                                    'You will otherwise comply with the terms and conditions of these Terms & Conditions'
                                    'and all applicable local, national, and international laws and regulations. TM8 reserves'
                                    'the right to discontinue any aspect of the Website or App at any time.',
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
                                    'YOUR USE OF CONTENT ON THE WEBSITE AND APP: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: 'In addition to the general'
                                    'restrictions above, the following restrictions and conditions apply specifically to your use'
                                    'of content on the Website and App. The content on the Website and App, including'
                                    'without limitation, the text, software, scripts, graphics, photos, sounds, music, videos,'
                                    'interactive features and the like (“',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Content',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: '") and the trademarks, service marks and'
                                    'logos contained therein ("',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Marks',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '") are owned by or licensed to TM8, subject to'
                                    'trademark, trade dress, copyright and other intellectual property rights under the law.'
                                    'Content on the Website and App is provided to you AS IS for your information and'
                                    'personal use only and may not be downloaded, copied, reproduced, distributed,'
                                    'transmitted, broadcast, displayed, sold, licensed, or otherwise exploited for any other'
                                    'purposes whatsoever without the prior written consent of the respective owners. TM8'
                                    'reserves all rights not expressly granted in and to the Website, the App, and the'
                                    'Content. You acknowledge and agree that any questions, comments, suggestions,'
                                    'ideas, feedback or other information about the Website or the Services, provided by you'
                                    'to TM8 are non-confidential and shall become the sole property of TM8. You agree to'
                                    'not engage in the use, copying, or distribution of any of the Content other than'
                                    'expressly permitted herein. You agree not to circumvent, disable or otherwise interfere'
                                    'with security-related features of the Website and App, or features that prevent or restrict'
                                    'use or copying of any Content or enforce limitations on use of the Website, the App, or'
                                    'the Content therein.',
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
                                text: 'MOBILE SERVICES: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'The TM8 Services may include certain services that may be'
                                    'available via your mobile phone, including but not limited to (i) the ability to purchase'
                                    'Services via your mobile phone, (ii) the ability to receive and reply to TM8 messages,'
                                    '(iii) the ability to browse the Website and App from your mobile phone and (iv) the ability'
                                    'to access certain TM8 features through the App you have downloaded and installed on'
                                    'your mobile phone (collectively the "',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Mobile Services',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: '"). We do not charge for these'
                                    'Mobile Services. However, your carrier’s normal messaging, data and other rates and'
                                    'fees will still apply. You should check with your carrier to find out what plans are'
                                    'available and how much they cost. In addition, downloading, installing, or using certain'
                                    'Mobile Services may be prohibited or restricted by your carrier, and not all Mobile'
                                    'Services may work with all carriers or devices. Therefore, you should check with your'
                                    'carrier to find out if the Mobile Services are available for your mobile devices, and what'
                                    'restrictions, if any, may be applicable to your use of such Mobile Services. By using the'
                                    'Mobile Services, you agree that we may communicate with you regarding TM8 and'
                                    'other entities by SMS, MMS, text message or other electronic means to your mobile'
                                    'device and that certain information about your usage of the Mobile Services may be'
                                    'communicated to us.',
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
                                text: 'NO RELIANCE ON THIRD-PARTY CONTENT: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: 'Opinions, advice, statements, or other'
                                    'information made available to you by third parties on our Site or App are those of their'
                                    'respective authors, and should not necessarily be relied upon. Those authors are solely'
                                    'responsible for their content. TM8 does not: (i) guarantee the accuracy, completeness,'
                                    'or usefulness of any third-party information accessible on or through the Services; or (ii)'
                                    'adopt, endorse, or accept responsibility for the accuracy or reliability of any opinion,'
                                    'advice, or statement made by a third party through the Services. You agree that TM8 is'
                                    'not liable for any loss or damage resulting from your reliance on information or other'
                                    'content transmitted to or by any third party. Also see section below (Links to Third'
                                    'Parties).',
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
                                text: 'CONTENT AND CONTENT RIGHTS: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: 'For purposes of these Terms: (i) “',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Content',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '" means graphics, images, music, software, audio, video, text, games, works of'
                                    'authorship of any kind, and information or other materials that are posted, generated,'
                                    'provided or otherwise made available through the TM8 Services; and (ii) “',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'User Content',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '" means any Content that TM8 account holders (including you) provide to be'
                                    'made available through the TM8 Services. Content includes without limitation User'
                                    'Content.',
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
                          'TM8 does not claim any ownership rights in any User Content that you make available'
                          'through the Services and nothing in these Terms will be deemed to restrict any rights'
                          'that you may have to use and exploit your User Content. Subject to the foregoing, TM8'
                          'and its licensors exclusively own all right, title and interest in and to the Services and'
                          'Content, including all associated intellectual property rights. You acknowledge that the'
                          'TM8 Services and Content are protected by copyright, trademark, and other laws of the'
                          'United States and foreign countries. You agree not to remove, alter or obscure any'
                          'copyright, trademark, service mark or other proprietary rights notices incorporated in or'
                          'accompanying the TM8 Services or Content or in any third-party Website or application'
                          'that you access in your use of the Services. See section below (TM8’s Proprietary'
                          'Rights).',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Text(
                          'If you send us User Content using the Services or tag us in Content on a social media'
                          'platform, we may use that Content for social media, Website, blog, email, advertising,'
                          'and other commercial uses. By making any User Content available through the Services'
                          'or through the submission of User Content, including photos and videos, whether sent'
                          'via message, location tag, or social media tagging, you grant TM8 a perpetual, royalty-'
                          'free, and unrestricted right and license to utilize the User Content in any and all'
                          'advertising, commercial, and marketing efforts, as well as to provide the Services. You'
                          'also grant permission for TM8 to use your name, photograph(s), likeness, image, and'
                          'transformation journey details in any and all marketing, print, Website, and social media'
                          'material and to provide the Services.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Text(
                          'You are solely responsible for all your User Content. You represent and warrant that'
                          'you own all your User Content or you have all rights that are necessary to grant us the'
                          'license rights in your User Content under these Terms. You also represent and warrant'
                          'that neither your User Content, nor your use and provision of your User Content to be'
                          'made available through the Services, nor any use of your User Content by TM8 on or'
                          'through the Services will infringe, misappropriate or violate a third party’s intellectual'
                          'property rights, or rights of publicity or privacy, or result in the violation of any applicable'
                          'law or regulation.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Text(
                          'You can remove your User Content by specifically deleting it. However, in certain'
                          'instances, some of your User Content (such as posts or comments you make) may not'
                          'be completely removed and copies of your User Content may continue to exist on the'
                          'Services or in our advertising or third-party media such as Facebook, Twitter, etc. We'
                          'are not responsible or liable for the removal or deletion of (or the failure to remove or'
                          'delete) any of your User Content.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Text(
                          'Subject to your compliance with these Terms, TM8 grants you a limited, non-exclusive,'
                          'non-transferable, non-sublicensable license to access and view the Content solely in'
                          'connection with your permitted use of the TM8 Services and solely for your personal'
                          'and non-commercial purposes.',
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
                                text: 'PROHIBITED CONDUCT: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'TM8 prohibits certain activities with respect to the Services'
                                    'and Content. Any violation of this section may subject you to civil and/or criminal'
                                    'liability. You understand that all User Content, whether publicly posted or privately'
                                    'transmitted, is the sole responsibility of the person from whom such User Content'
                                    'originated. You understand that by using the TM8 Services, you may be exposed to'
                                    'Content from other users that may be offensive or objectionable. TM8 has no'
                                    'responsibility in any way for any Content, including, but not limited to, any errors or'
                                    'omissions in any User Content, or any loss or damage of any kind incurred as a result'
                                    'of the use of any User Content posted, emailed, transmitted or otherwise made'
                                    'available via the Services.',
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
                          'We ask that you respect the TM8 community of users and our desire for all users to feel'
                          'safe when using the Services, including any Content. Accordingly, you agree you will'
                          'not use the TM8 Services to:',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '1. upload, post, email, transmit or otherwise make available any Content that is'
                                'unlawful, harmful, threatening, abusive, harassing, tortious, defamatory, vulgar,'
                                'obscene, libelous, invasive of another’s privacy, hateful, or racially, ethnically or'
                                'otherwise objectionable to any individual or group;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '2. upload, post, email, transmit or otherwise make available any Content that'
                                'exploits minors, promotes illegal or harmful activities or substances or promotes'
                                'violence or violent actions against another person, animal or entity;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '3. upload, post, email, transmit or otherwise make available any Content that'
                                'infringes any patent, trademark, trade secret, copyright, privacy, publicity or other'
                                'proprietary rights of any party;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '4. upload, post, email, transmit or otherwise make available any unsolicited or'
                                'unauthorized advertising, promotional materials, “junk mail,” “spam,” “chain'
                                'letters,” “pyramid schemes,” or any other form of solicitation;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '5. upload, post, email, transmit or otherwise make available any Content that you'
                                'do not have a right to make available under any law or under contractual or'
                                'fiduciary relationships (such as inside information, proprietary and confidential'
                                'information learned or disclosed as part of employment relationships or under'
                                'nondisclosure agreements);',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '6. forge headers or otherwise manipulate identifiers in order to disguise the origin of'
                                'any Content transmitted through the Services;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '7. upload, post, email, transmit or otherwise make available any material that'
                                'contains software viruses, “Trojan horses” or any other computer code, files or'
                                'programs designed to interrupt, destroy or limit the functionality of any computer'
                                'software or hardware or telecommunications equipment;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '8. intentionally or unintentionally violate any applicable local, state, national or'
                                'international law, including, but not limited to, regulations promulgated by the'
                                'U.S. Securities and Exchange Commission, any rules of any national or other'
                                'securities exchange, including, without limitation, the New York Stock Exchange,'
                                'the American Stock Exchange or the NASDAQ, and any regulations having the'
                                'force of law;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '9. collect or store personal data about other users in connection with the prohibited'
                                'conduct and activities set forth in paragraphs a through h above.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Text(
                          'The following are expressly prohibited when using the Services:',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '1. interfering with or disrupting the TM8 Services or servers or networks connected'
                                'to the Services, or disobeying any requirements, procedures, policies or'
                                'regulations of networks connected to the Services, including using any device,'
                                'software or routine to bypass our robot exclusion headers;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '2. using or attempting to use any engine, software, tool, agent, or other device or'
                                'mechanism (including without limitation browsers, spiders, robots, avatars, or'
                                'intelligent agents) to harvest or otherwise collect information from the Site or App'
                                'for any use, including without limitation use on third-party Websites;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '3. modifying or changing the placement, content or location of any advertisement'
                                'posted through the Services;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '4. providing fraudulent, false, misleading, or inaccurate information to TM8 or any'
                                'other person in connection with the Services;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '5. impersonating, or otherwise misrepresenting affiliation, connection, or'
                                'association with, any person or entity;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '6. stalking or harassing anyone;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '7. accessing content or data not intended for you, or logging into a server or'
                                'account that you are not authorized to access;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '8. attempting to probe, scan, or test the vulnerability of the Services, or any'
                                'associated system or network, or breaching security or authentication measures'
                                'without proper authorization;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '9. interfering or attempting to interfere with the use of the Services by any other'
                                'user, host, or network, including (without limitation) by submitting malware or'
                                'exploiting software vulnerabilities;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '10. forging, modifying, or falsifying any network packet or protocol header or'
                                'metadata in any connection with, or transmission to, the Services (for example,'
                                'SMTP email headers, HTTP headers, or Internet Protocol packet headers);',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '11. while using the Services, using ad-blocking or other content-blocking software,'
                                'browser extensions, or built-in browser options designed to hide, block, or'
                                'prevent the proper display of online advertising;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '12. attempting to modify, reverse-engineer, decompile, disassemble, or otherwise'
                                'reduce or attempt to reduce to a human-perceivable form any of the source code'
                                'used by TM8 or its third-party contractors in providing the Services, including'
                                'without limitation any fraudulent effort to modify software or any other'
                                'technological mechanism for measuring the number of impressions generated by'
                                'individual content and/or the overall Services to determine and/or audit'
                                'advertising revenues and payments, if applicable;',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '13. creating additional accounts to promote your (or another’s) business, or causing'
                                'others to do so; or',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              h10,
                              Text(
                                '14. paying anyone for interactions on the Services.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        h10,
                        Text(
                          'Although TM8 is not obligated to monitor access to, or use of, the Services or Content'
                          'or to review or edit any Content, we have the right to do so for the purpose of operating'
                          'the Services, to ensure compliance with these Terms, or to comply with applicable law'
                          'or other legal requirements. TM8 reserves the right, but is not obligated, to remove or'
                          'disable access to any Content, at any time and without notice, including, but not limited'
                          'to, if we, at our sole discretion, consider any Content to be objectionable or in violation'
                          'of these Terms. TM8 has the right to investigate violations of these Terms or conduct'
                          'that affects the TM8 Services. We may also consult and cooperate with law'
                          'enforcement authorities to prosecute users who violate the law.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Text(
                          'You acknowledge, consent and agree that TM8 may access, preserve and disclose'
                          'your account information or User Content if required to do so by law or in a good faith'
                          'belief that such access preservation or disclosure is reasonably necessary to: (i) comply'
                          'with legal process; (ii) enforce these Terms (iii) respond to your requests for customer'
                          'service; or (v) protect the rights, property or personal safety of TM8, its users or the'
                          'public.',
                          style: body1Regular.copyWith(
                            color: achromatic300,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        h10,
                        Text(
                          'You understand that the Services and software embodied within the Services may'
                          'include security components that permit digital materials to be protected, and that use of'
                          'these materials is subject to usage rules set by TM8 and/or content providers who'
                          'provide Content to the Services. You may not attempt to override or circumvent any of'
                          'the usage rules embedded into the Services. Any unauthorized reproduction,'
                          'publication, further distribution or public exhibition of the materials provided on the'
                          'Services, in whole or in part, is strictly prohibited.',
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
                                text: 'RIGHTS AND TERMS FOR SERVICES: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Subject to your compliance with these Terms,'
                                    'and in addition to the Content license granted above, TM8 grants you a limited non-'
                                    'exclusive, non-transferable, non-sublicensable license to access and use the Services,'
                                    'download and install a copy of the App on a mobile device or computer that you own or'
                                    'control and to run such copy of the App solely for your own personal non-commercial'
                                    'purposes. If you would like to install the App on any additional device of yours, you will'
                                    'need to download the App again for the additional device. TM8 reserves all rights in and'
                                    'to the App not expressly granted to you under these Terms.',
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
                                text: 'ADDITIONAL TERMS FOR APP STORE APPS: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: 'If you download the App through or'
                                    'from any app store or distribution platform (like the Apple App Store or Google Play)'
                                    'where the App is made available (each, an “',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'App Provider',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: '") then you acknowledge and'
                                    'agree that these Terms are between you and TM8, and not with the App Provider, and'
                                    'the App Provider is not responsible for the App and has no obligation to furnish to you'
                                    'any maintenance and support services with respect to the App except the right to have'
                                    'the purchase refunded, if applicable, as provided in these Terms. In the event of any'
                                    'failure of the App to conform to any applicable warranty, you may notify the App'
                                    'Provider, and the App Provider will refund the purchase price for the App to you (if'
                                    'applicable) and to the maximum extent permitted by applicable law, the App Provider'
                                    'will have no other warranty obligation whatsoever with respect to the App. The App'
                                    'Provider is not responsible for addressing any claims you have or any claims of any'
                                    'third party relating to the App or your possession and use of the App, including, but not'
                                    'limited to: (i) product liability claims; (ii) any claim that the App fails to conform to any'
                                    'applicable legal or regulatory requirement; and (iii) claims arising under consumer'
                                    'protection or similar legislation. You must also comply with all applicable third-party'
                                    'terms of service, which can be found under Terms & Conditions when using the App. In'
                                    'the event of any other claims, losses, liabilities, damages, costs or expenses'
                                    'attributable to any failure to conform to any warranty, see the warranty section of these'
                                    'Terms.',
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
                          'The App Provider and its subsidiaries are third party beneficiaries of these Terms as'
                          'related to your license of the App, and that, upon your acceptance of these Terms, the'
                          'App Provider will have the right (and will be deemed to have accepted the right) to'
                          'enforce these Terms as related to your license of the App against you as a third party'
                          'beneficiary thereof.',
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
                                text: 'ADVERTISERS: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Your dealings with, or participation in promotions of, advertisers or'
                                    'other third parties found on or through the TM8 Services, including payment and'
                                    'delivery of related goods or services, and any other Terms, conditions, warranties or'
                                    'representations associated with such dealings, are solely between you and such'
                                    'advertiser or third party. You agree that TM8 will not be responsible or liable for any loss'
                                    'or damage of any sort incurred as the result of any such dealings with advertisers or'
                                    'third parties, or as the result of the presence of such advertisers in the Services.',
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
                                text: 'LINKS TO THIRD PARTIES: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'The Services may contain links to third-party Websites or'
                                    'resources. TM8 provides these links only as a convenience. You acknowledge and'
                                    'agree that TM8 is not responsible for the availability of such external sites or resources,'
                                    'and does not endorse and is not responsible or liable for any Content, advertising,'
                                    'products or other materials on or available from such sites or resources. You further'
                                    'acknowledge sole responsibility for and assume all risk arising from, your use of any'
                                    'third-party Websites or resources and agree that TM8 will not be responsible or liable,'
                                    'directly or indirectly, for any damage or loss caused or alleged to be caused by or in'
                                    'connection with use of or reliance on any Content, goods or services available on or'
                                    'through any such Website or resource..',
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
                                text: 'ACCOUNT TERMINATION POLICY: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'TM8 will terminate a User’s access to its Website,'
                                    'the App, or the Mobile Services if, under appropriate circumstances, they are'
                                    'determined to be a repeat infringer of this Terms & Conditions or any other policy of'
                                    'TM8.',
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
                                text: 'TM8’S PROPRIETARY RIGHTS: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'You acknowledge and agree that the TM8 Services'
                                    'and Content provided through the TM8 Services contain software and other proprietary'
                                    'and confidential information that is protected by copyrights, patents, trademarks, trade'
                                    'secrets and other proprietary rights, and that these rights are valid and protected in all'
                                    'forms, media and technologies existing now or hereafter developed. You further'
                                    'acknowledge and agree that Content contained in advertisements or information'
                                    'presented to you through the TM8 Services or by advertisers is protected by copyrights'
                                    '(each work by an individual copyright), trademarks, service marks, patents or other'
                                    'proprietary rights and laws in all jurisdictions in the US and internationally in some'
                                    'cases. Except as expressly permitted by applicable law or as authorized by TM8 or the'
                                    'applicable licensor (such as an advertiser), you agree not to modify, rent, lease, loan,'
                                    'sell, distribute, transmit, broadcast, publicly perform or create derivative works based on'
                                    'the Services or Content, in whole or in part. As between you and TM8, TM8 owns or'
                                    'has a license to all intellectual property rights in the selection, coordination,'
                                    'arrangement, and enhancement of all content in the Services. You agree that all of the'
                                    'trademarks, trade names, service marks and other logos and brand features, and'
                                    'product and service names (collectively, “',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                              TextSpan(
                                text: 'Marks',
                                style: body1Regular.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: '") contained in the Services or Content'
                                    'are trademarks and the property of either TM8 or are licensed to TM8. Without TM8’s'
                                    'prior permission, you agree not to display or use in any manner the Marks.',
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
                                text: 'DISCLAIMER OF WARRANTIES: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: 'YOU AGREE THAT YOUR USE OF THE WEBSITE'
                                    'AND MOBILE SERVICES SHALL BE AT YOUR SOLE RISK. TO THE FULLEST'
                                    'EXTENT PERMITTED BY LAW, TM8, ITS OFFICERS, DIRECTORS, EMPLOYEES,'
                                    'AND AGENTS DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN'
                                    'CONNECTION WITH THE WEBSITE AND MOBILE SERVICES AND YOUR USE'
                                    'THEREOF. TM8 MAKES NO WARRANTIES OR REPRESENTATIONS ABOUT THE'
                                    'ACCURACY OR COMPLETENESS OF THIS SITE’S CONTENT OR THE CONTENT'
                                    'OF ANY SITES LINKED TO THIS SITE AND ASSUMES NO LIABILITY OR'
                                    'RESPONSIBILITY FOR ANY (I) ERRORS, MISTAKES, OR INACCURACIES OF'
                                    'CONTENT, (II) PERSONAL INJURY OR DEATH OR PROPERTY DAMAGE, OF ANY'
                                    'NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF'
                                    'OUR WEBSITE OR FROM THE CONDUCT OF ANY USERS OF THE TM8'
                                    'SERVICES, WHETHER ONLINE OR OFFLINE, (III) ANY UNAUTHORIZED ACCESS'
                                    'TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL'
                                    'INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (IV) ANY'
                                    'INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM OUR'
                                    'WEBSITE, (V) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY'
                                    'BE TRANSMITTED TO OR THROUGH OUR WEBSITE BY ANY THIRD PARTY,'
                                    'AND/OR (VI) ANY ERRORS OR OMISSIONS IN ANY CONTENT OR FOR ANY LOSS'
                                    'OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY'
                                    'CONTENT POSTED, EMAILED, TRANSMITTED, OR OTHERWISE MADE'
                                    'AVAILABLE VIA THE TM8 WEBSITE. TM8 DOES NOT WARRANT, ENDORSE,'
                                    'GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE'
                                    'ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE TM8 WEBSITE'
                                    'OR ANY HYPERLINKED WEBSITE OR FEATURED IN ANY BANNER OR OTHER'
                                    'ADVERTISING, AND TM8 WILL NOT BE A PARTY TO OR IN ANY WAY BE'
                                    'RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND'
                                    'THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES. AS WITH THE'
                                    'PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY'
                                    'ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE'
                                    'CAUTION WHERE APPROPRIATE. THE TM8 SERVICES ARE PROVIDED “AS-IS”'
                                    'AND AS AVAILABLE AND TM8 EXPRESSLY DISCLAIMS ANY WARRANTY OF'
                                    'FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT. TM8 CANNOT'
                                    'GUARANTEE AND DOES NOT PROMISE ANY SPECIFIC RESULTS FROM USE OF'
                                    'THE TM8 SERVICES.',
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
                                text: 'LIMITATION OF LIABILITY: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: 'IN NO EVENT SHALL TM8, ITS OFFICERS,'
                                    'DIRECTORS, EMPLOYEES, OR AGENTS, BE LIABLE TO YOU FOR ANY DIRECT,'
                                    'INDIRECT, INCIDENTAL, SPECIAL, PUNITIVE, OR CONSEQUENTIAL DAMAGES'
                                    'WHATSOEVER RESULTING FROM ANY (I) ERRORS, MISTAKES, OR'
                                    'INACCURACIES OF CONTENT, (II) PERSONAL INJURY OR PROPERTY DAMAGE,'
                                    'OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE'
                                    'OF OUR WEBSITE, (III) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR'
                                    'SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR'
                                    'FINANCIAL INFORMATION STORED THEREIN, (IV) ANY INTERRUPTION OR'
                                    'CESSATION OF TRANSMISSION TO OR FROM OUR WEBSITE, (V) ANY BUGS,'
                                    'VIRUSES, TROJAN HORSES, OR THE LIKE, WHICH MAY BE TRANSMITTED TO'
                                    'OR THROUGH OUR WEBSITE BY ANY THIRD PARTY, AND/OR (VI) ANY ERRORS'
                                    'OR OMISSIONS IN ANY CONTENT OR FOR ANY LOSS OR DAMAGE OF ANY KIND'
                                    'INCURRED AS A RESULT OF YOUR USE OF ANY CONTENT POSTED, EMAILED,'
                                    'TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE TM8 WEBSITE OR'
                                    'THROUGH USE OF THE MOBILE SERVICES, WHETHER BASED ON WARRANTY,'
                                    'CONTRACT, TORT, OR ANY OTHER LEGAL THEORY, AND WHETHER OR NOT'
                                    'THE COMPANY IS ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. THE'
                                    'FOREGOING LIMITATION OF LIABILITY SHALL APPLY TO THE FULLEST EXTENT'
                                    'PERMITTED BY LAW IN THE APPLICABLE JURISDICTION. YOU SPECIFICALLY'
                                    'ACKNOWLEDGE THAT TM8 SHALL NOT BE LIABLE FOR USER SUBMISSIONS OR'
                                    'THE DEFAMATORY, OFFENSIVE, OR ILLEGAL CONDUCT OF ANY THIRD PARTY'
                                    'AND THAT THE RISK OF HARM OR DAMAGE FROM THE FOREGOING RESTS'
                                    'ENTIRELY WITH YOU. The Website, the App, and the Mobile Services are controlled'
                                    'and offered by TM8 from its facility in the United States of America. TM8 makes no'
                                    'representations that the Website, the App, or the Mobile Services are appropriate or'
                                    'available for use in other locations. Those who access or use the Website, the App, or'
                                    'the Mobile Services from other jurisdictions do so at their own volition and are'
                                    'responsible for compliance with local law.',
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
                                text: 'INDEMNITY: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'You agree to defend, indemnify and hold harmless TM8, its affiliates,'
                                    'parent corporation, officers, directors, employees and agents, from and against any and'
                                    'all claims, damages, obligations, losses, liabilities, costs or debt, and expenses'
                                    '(including but not limited to attorney’s fees) arising from your use of and access to the'
                                    'Website, the App, and the Mobile Services, or your violation of any term of these Terms'
                                    '& Conditions. This defense and indemnification obligation will survive these Terms &'
                                    'Conditions and your use of the Website, the App, and the Mobile Services.',
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
                                text: 'ABILITY TO ACCEPT TERMS OF SERVICE: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: 'You affirm that you are either more than'
                                    '18 years of age, or an emancipated minor, or possess legal parental or guardian'
                                    'consent, and are fully able and competent to enter into the terms, conditions,'
                                    'obligations, affirmations, representations, and warranties set forth in these Terms &'
                                    'Conditions, and to abide by and comply with these Terms & Conditions. In any case,'
                                    'you affirm that you are 13 years of age or older, as neither the Website, the App, nor the'
                                    'Mobile Services are intended for children under 13. If you are under 13 years of age,'
                                    'then please do not use the TM8 Website, TM8 App, or the TM8 Mobile Services.',
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
                                text: 'ASSIGNMENT: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'These Terms & Conditions, and any rights and licenses granted'
                                    'hereunder, may not be transferred or assigned by you, but may be assigned by TM8'
                                    'without restriction.',
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
                                text: 'NO THIRD-PARTY BENEFICIARIES: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'You agree that, except as otherwise expressly'
                                    'provided in these Terms, there will be no third-party beneficiaries to this agreement.',
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
                                text: 'GOVERNING LAW; VENUE AND JURISDICTION: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text: 'You agree that: (i) the Website, the'
                                    'App, and the Mobile Services shall be deemed solely based in Florida; and (ii) the'
                                    'Website, App and Mobile Services shall be deemed a passive Website that does not'
                                    'give rise to personal jurisdiction over TM8, either specific or general, in jurisdictions'
                                    'other than Florida. These Terms & Conditions shall be governed by the internal'
                                    'substantive laws of the state of Florida, without respect to its conflict of laws principles.'
                                    'Any claim or dispute between you and TM8 that arises in whole or in part from the'
                                    'Website, App, or the Mobile Services shall be decided exclusively by a court of'
                                    'competent jurisdiction located in Alachua County, Florida, and you hereby consent to,'
                                    'and waive all defenses of lack of personal jurisdiction and forum non conveniens with'
                                    'respect to, venue and jurisdiction in the state and federal courts of Florida. These Terms'
                                    '& Conditions, together with the Privacy Policy and any other legal notices published by'
                                    'TM8 on the Website and the App, shall constitute the entire agreement between you'
                                    'and TM8 concerning the Website, the App, and the Mobile Services. If any provision of'
                                    'these Terms & Conditions is deemed invalid by a court of competent jurisdiction, the'
                                    'invalidity of such provision shall not affect the validity of the remaining provisions of'
                                    'these Terms & Conditions, which shall remain in full force and effect. No waiver of any'
                                    'term of these Terms & Conditions shall be deemed a further or continuing waiver of'
                                    'such term or any other term, and TM8’s failure to assert any right or provision under'
                                    'these Terms & Conditions shall not constitute a waiver of such right or provision. TM8'
                                    'reserves the right to amend these Terms & Conditions at any time and without notice,'
                                    'and it is your responsibility to review these Terms & Conditions for any changes. Your'
                                    'use of the Website or App following any amendment of these Terms & Conditions will'
                                    'signify your assent to and acceptance of its revised terms. TO THE EXTENT'
                                    'PERMITTED BY APPLICABLE LAW, YOU AND TM8 AGREE THAT ANY CAUSE OF'
                                    'ACTION ARISING OUT OF OR RELATED TO THE WEBSITE MUST COMMENCE'
                                    'WITHIN ONE (1) YEAR AFTER THE CAUSE OF ACTION ACCRUES. OTHERWISE,'
                                    'SUCH CAUSE OF ACTION IS PERMANENTLY BARRED.',
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
                                text: 'ARBITRATION: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'YOU AND TM8 AGREE THAT, EXCEPT AS MAY OTHERWISE BE'
                                    'PROVIDED IN REGARD TO SPECIFIC SERVICES ON THE WEBSITE OR THE APP'
                                    'IN ANY SPECIFIC TERMS APPLICABLE TO THOSE SERVICES, THE SOLE AND'
                                    'EXCLUSIVE FORUM AND REMEDY FOR ANY AND ALL DISPUTES AND CLAIMS'
                                    'RELATING IN ANY WAY TO OR ARISING OUT OF THESE TERMS OF SERVICE,'
                                    'THE WEBSITE, APP, AND/OR THE MOBILE SERVICES, SHALL BE FINAL AND'
                                    'BINDING ARBITRATION, except that to the extent that either of us has in any manner'
                                    'infringed upon or violated or threatened to infringe upon or violate the other party’s'
                                    'patent, copyright, trademark or trade secret rights, or you have otherwise violated any of'
                                    'the User conduct rules set forth above then the parties acknowledge that arbitration is'
                                    'not an adequate remedy at law and that injunctive or other appropriate relief may be'
                                    'sought. Either TM8 or you may demand that any dispute between and you about or'
                                    'involving the Services must be settled by arbitration utilizing the dispute resolution'
                                    'procedures of the American Arbitration Association (AAA) in Alachua County, Florida,'
                                    'provided that the foregoing shall not prevent TM8 from seeking injunctive relief in a'
                                    'court of competent jurisdiction. To the fullest extent permitted by applicable law, NO'
                                    'ARBITRATION OR CLAIM UNDER THESE TERMS OF SERVICE SHALL BE JOINED'
                                    'TO ANY OTHER ARBITRATION OR CLAIM, INCLUDING ANY ARBITRATION OR'
                                    'CLAIM INVOLVING ANY OTHER CURRENT OR FORMER USER OF THE SERVICE,'
                                    'AND NO CLASS ARBITRATION PROCEEDINGS SHALL BE PERMITTED.',
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
                                text: 'SUBMISSIONS: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'You acknowledge and agree that any questions, comments,'
                                    'suggestions, ideas, feedback or other information about the Website, the App, or the'
                                    'Mobile Services, provided by you to TM8: (a) do not contain confidential or proprietary'
                                    'information and do not infringe the intellectual property rights of any other person or'
                                    'entity; (b) that TM8 is not under any obligation of confidentiality, express or implied, with'
                                    'respect to the Submissions; (c) that TM8 will be entitled to use or disclose (or choose'
                                    'not to use or disclose) such Submissions for any purpose, in any way, in any media'
                                    'worldwide; (d) TM8 may have something similar to the Submissions already under'
                                    'consideration or in development; (e) your Submissions automatically become the'
                                    'property of TM8 without any obligation of TM8 to you; and (f) you are not entitled to any'
                                    'compensation or reimbursement of any kind from TM8 under any circumstances. You'
                                    'hereby assign and agree to assign any rights you may have in your Submissions to'
                                    'TM8. TM8 shall own exclusive rights, including all intellectual property rights, and shall'
                                    'be entitled to the unrestricted use and dissemination of such information for any'
                                    'purpose, commercial or otherwise, without acknowledgment or compensation to you.',
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
                                text: 'HOW TO CONTACT US: ',
                                style: body1Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'If you have any questions or concerns about the TM8 Terms'
                                    '& Conditions for this site, its implementation or your personal information, you may'
                                    'contact us by email at: jgergley@tm8gaming.com, by telephone at (239) 848-7958, or'
                                    'by postal mail to TM8 Gaming LLC, 622 NW 3RD Ave APT 1, Gainesville, FL, 32601-'
                                    '5722.',
                                style: body1Regular.copyWith(
                                  color: achromatic300,
                                ),
                              ),
                            ],
                          ),
                        ),
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
