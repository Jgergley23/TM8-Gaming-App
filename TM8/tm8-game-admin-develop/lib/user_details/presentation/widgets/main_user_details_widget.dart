import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_container_widget.dart';
import 'package:tm8_game_admin/env/env.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';
import 'package:tm8_game_admin/user_details/presentation/widgets/user_details_detail_widget.dart';

class MainUserDetailsWidget extends StatelessWidget {
  const MainUserDetailsWidget({
    super.key,
    required this.user,
  });

  final UserResponse user;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Tm8MainContainerWidget(
      padding: 16,
      borderRadius: 30,
      width: MediaQuery.of(context).size.width * 0.8,
      content: Stack(
        children: [
          Container(
            height: 150,
            width: 225,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: achromatic600,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  padding: REdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: user.photoKey != null
                      ? ClipOval(
                          child: Image.network(
                            '${Env.baseUrlAmazon}/${user.photoKey}',
                            fit: BoxFit.fitWidth,
                          ),
                        )
                      : SvgPicture.asset(
                          Assets.common.userPlaceholder.path,
                          colorFilter: ColorFilter.mode(
                            achromatic600,
                            BlendMode.srcIn,
                          ),
                        ),
                ),
                h12,
                Text(
                  user.username ?? '-',
                  style: body1Regular.copyWith(color: achromatic100),
                ),
                h2,
                Text(
                  user.email ?? '',
                  style: body1Regular.copyWith(
                    color: achromatic200,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (MediaQuery.of(context).size.width > 650) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 250,
                    top: 30,
                  ),
                  child: _buildUserDetailsWrap(now),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 162),
                  child: _buildUserDetailsWrap(now),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Wrap _buildUserDetailsWrap(DateTime now) {
    return Wrap(
      runSpacing: 12,
      children: [
        UserDetailsDetailWidget(
          asset: 'assets/user/user.svg',
          category: 'Age',
          value: user.dateOfBirth != null
              ? '${now.difference(user.dateOfBirth!).inDays ~/ 365}'
              : '-',
        ),
        UserDetailsDetailWidget(
          asset: 'assets/user/user_timezone.svg',
          category: 'Timezone',
          value: user.timezone ?? '-',
        ),
        UserDetailsDetailWidget(
          asset: 'assets/user/user_status.svg',
          category: 'Status',
          value: user.status?.type.name ?? 'name',
        ),
        // const UserDetailsDetailWidget(
        //   asset: 'assets/user/user.svg',
        //   category: 'Average screentime',
        //   value: '-',
        // ),
        UserDetailsDetailWidget(
          asset: 'assets/user/user_date_joined.svg',
          category: 'Joined',
          value:
              DateFormat('MM/dd/yyyy').format(user.createdAt ?? DateTime.now()),
        ),
        UserDetailsDetailWidget(
          asset: 'assets/user/user_country.svg',
          category: 'Country',
          value: user.country ?? '-',
        ),
        const UserDetailsDetailWidget(
          asset: 'assets/user/user_epic_games_account.svg',
          category: 'Epic Games account',
          value: '-',
        ),
        UserDetailsDetailWidget(
          asset: 'assets/user/user_epic_games_account.svg',
          category: 'User Rating',
          value:
              user.rating!.ratings.isEmpty ? '-' : '${user.rating?.average}/5',
        ),
      ],
    );
  }
}
