import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8SideMenuWidget extends StatefulWidget {
  const Tm8SideMenuWidget({
    super.key,
    required this.pageIndex,
    required this.currentIndex,
  });

  final Function(int) pageIndex;
  final int currentIndex;

  @override
  State<Tm8SideMenuWidget> createState() => _Tm8SideMenuWidgetState();
}

class _Tm8SideMenuWidgetState extends State<Tm8SideMenuWidget> {
  @override
  Widget build(Object context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).size.width > 1050) {
          return _WideLayout(
            changePage: widget.pageIndex,
            currentIndex: widget.currentIndex,
          );
        } else {
          return _NarrowLayout(
            changePage: widget.pageIndex,
            currentIndex: widget.currentIndex,
          );
        }
      },
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout({
    required this.changePage,
    required this.currentIndex,
  });

  final Function(int) changePage;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.18,
      color: achromatic800,
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 46,
              bottom: 78,
            ),
            child: SvgPicture.asset('assets/logo.svg'),
          ),
          InkWell(
            onTap: () {
              changePage(0);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              decoration: currentIndex == 0
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: achromatic500,
                    )
                  : null,
              child: Row(
                children: [
                  w12,
                  SvgPicture.asset(
                    'assets/menu/users_menu.svg',
                    colorFilter: ColorFilter.mode(
                      currentIndex == 0 ? achromatic100 : achromatic200,
                      BlendMode.srcIn,
                    ),
                  ),
                  w6,
                  Text(
                    'Users',
                    style: body1Regular.copyWith(
                      color: currentIndex == 0 ? achromatic100 : achromatic200,
                    ),
                  ),
                ],
              ),
            ),
          ),
          h14,
          InkWell(
            onTap: () {
              changePage(1);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              decoration: currentIndex == 1
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: achromatic500,
                    )
                  : null,
              child: Row(
                children: [
                  w12,
                  SvgPicture.asset(
                    'assets/menu/notifications.svg',
                    colorFilter: ColorFilter.mode(
                      currentIndex == 1 ? achromatic100 : achromatic200,
                      BlendMode.srcIn,
                    ),
                  ),
                  w6,
                  Text(
                    'Notifications',
                    style: body1Regular.copyWith(
                      color: currentIndex == 1 ? achromatic100 : achromatic200,
                    ),
                  ),
                ],
              ),
            ),
          ),
          h14,
          InkWell(
            onTap: () {
              changePage(2);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              decoration: currentIndex == 2
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: achromatic500,
                    )
                  : null,
              child: Row(
                children: [
                  w12,
                  SvgPicture.asset(
                    'assets/menu/manage_admins.svg',
                    colorFilter: ColorFilter.mode(
                      currentIndex == 2 ? achromatic100 : achromatic200,
                      BlendMode.srcIn,
                    ),
                  ),
                  w6,
                  Text(
                    'Manage admins',
                    style: body1Regular.copyWith(
                      color: currentIndex == 2 ? achromatic100 : achromatic200,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({
    required this.changePage,
    required this.currentIndex,
  });
  final Function(int) changePage;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      color: achromatic800,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 46,
              bottom: 24,
            ),
            child: SizedBox(
              width: 80,
              child: SvgPicture.asset(
                'assets/logo.svg',
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              changePage(0);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              decoration: currentIndex == 0
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: achromatic500,
                    )
                  : null,
              child: SvgPicture.asset(
                'assets/menu/users_menu.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 0 ? achromatic100 : achromatic200,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          h14,
          InkWell(
            onTap: () {
              changePage(1);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              decoration: currentIndex == 1
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: achromatic500,
                    )
                  : null,
              child: SvgPicture.asset(
                'assets/menu/notifications.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 1 ? achromatic100 : achromatic200,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          h14,
          InkWell(
            onTap: () {
              changePage(2);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              decoration: currentIndex == 2
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: achromatic500,
                    )
                  : null,
              child: SvgPicture.asset(
                'assets/menu/manage_admins.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 2 ? achromatic100 : achromatic200,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
