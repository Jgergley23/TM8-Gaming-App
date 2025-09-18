import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tm8l/app/constants/constants.dart';
import 'package:tm8l/app/constants/fonts.dart';
import 'package:tm8l/app/constants/palette.dart';
import 'package:tm8l/gen/assets.gen.dart';

class LandingPageNavBarWidget extends StatelessWidget {
  const LandingPageNavBarWidget({
    super.key,
    required this.onPressed,
    required this.page,
  });

  final Function(int) onPressed;
  final int page;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final maxWidth = constrains.maxWidth;

        if (maxWidth < 900) {
          return _NarrowLayout(
            onPressed: onPressed,
            page: page,
          );
        } else {
          return _WideLayout(
            onPressed: onPressed,
            page: page,
          );
        }
      },
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout({
    required this.onPressed,
    required this.page,
  });

  final Function(int p1) onPressed;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 112, vertical: 20),
      child: Row(
        children: [
          SvgPicture.asset(Assets.images.logo.path),
          w40,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  onPressed(0);
                },
                child: Text(
                  'Home',
                  style: heading4Bold.copyWith(
                    color: page == 0 ? achromatic100 : achromatic300,
                  ),
                ),
              ),
              w32,
              InkWell(
                onTap: () {
                  onPressed(1);
                },
                child: Text(
                  'About',
                  style: heading4Bold.copyWith(
                    color: page == 1 ? achromatic100 : achromatic300,
                  ),
                ),
              ),
              w32,
              InkWell(
                onTap: () {
                  onPressed(2);
                },
                child: Text(
                  'Contact',
                  style: heading4Bold.copyWith(
                    color: page == 2 ? achromatic100 : achromatic300,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              SvgPicture.asset(Assets.images.appleButton.path),
              w12,
              SvgPicture.asset(Assets.images.googleButton.path),
            ],
          ),
        ],
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({
    required this.onPressed,
    required this.page,
  });

  final Function(int p1) onPressed;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 12,
        spacing: 20,
        children: [
          SvgPicture.asset(
            Assets.images.logo.path,
            width: 60,
            height: 28,
            fit: BoxFit.scaleDown,
          ),

          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  onPressed(0);
                },
                child: Text(
                  'Home',
                  style: heading4Bold.copyWith(
                    color: page == 0 ? achromatic100 : achromatic300,
                  ),
                ),
              ),
              w32,
              InkWell(
                onTap: () {
                  onPressed(1);
                },
                child: Text(
                  'About',
                  style: heading4Bold.copyWith(
                    color: page == 1 ? achromatic100 : achromatic300,
                  ),
                ),
              ),
              w32,
              InkWell(
                onTap: () {
                  onPressed(2);
                },
                child: Text(
                  'Contact',
                  style: heading4Bold.copyWith(
                    color: page == 2 ? achromatic100 : achromatic300,
                  ),
                ),
              ),
            ],
          ),
          // const Spacer(),
          // Row(
          //   children: [
          //     SvgPicture.asset(Assets.images.appleButton.path),
          //     w12,
          //     SvgPicture.asset(Assets.images.googleButton.path),
          //   ],
          // )
        ],
      ),
    );
  }
}
