import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm8l/app/constants/routing_names.dart';
import 'package:tm8l/app/services/service_locator.dart';
import 'package:tm8l/landing_page/logic/send_contact_form_cubit/send_contact_form_cubit.dart';
import 'package:tm8l/landing_page/view/about_page_screen.dart';
import 'package:tm8l/landing_page/view/contact_page_screen.dart';
import 'package:tm8l/landing_page/view/home_page_screen.dart';
import 'package:tm8l/landing_page/widgets/landing_page_navbar_widget.dart';

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({
    super.key,
    required this.page,
  });

  final int page;

  @override
  State<LandingPageScreen> createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  PageController pageController = PageController();
  int page = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.page);
    page = widget.page;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            page: page,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const HomePageScreen(),
                const AboutPageScreen(),
                BlocProvider(
                  create: (context) => sl<SendContactFormCubit>(),
                  child: const ContactPageScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
