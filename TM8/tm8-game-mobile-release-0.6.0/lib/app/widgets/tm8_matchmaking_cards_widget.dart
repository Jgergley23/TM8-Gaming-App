import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';

class Tm8MatchMakingCardsWidget extends StatelessWidget {
  const Tm8MatchMakingCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: achromatic700,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/user/avatar_default.png',
                        height: 24,
                        width: 24,
                      ),
                      w8,
                      Text(
                        'purpleLeopard757',
                        style: body1Regular.copyWith(color: achromatic100),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 32,
                      width: 32,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: achromatic500,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/common/plus.svg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 18),
                child: Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
          h12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGameColumn(name: 'Player level', type: 'Intermediate'),
              _buildGameColumn(name: 'K/D Ratio', type: '120'),
              _buildGameColumn(name: 'Win Rate', type: '50%'),
              _buildGameColumn(name: 'Rank', type: 'Silver'),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildGameColumn({required String name, required String type}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: captionRegular.copyWith(
            color: achromatic200,
          ),
        ),
        Text(
          type,
          style: body2Regular.copyWith(
            color: achromatic100,
          ),
        ),
      ],
    );
  }
}
