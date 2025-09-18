import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class Tm8PaginationWidget extends StatelessWidget {
  const Tm8PaginationWidget({
    super.key,
    required this.onTap,
    required this.meta,
  });

  final Function(int) onTap;
  final PaginationMetaResponse meta;

  @override
  Widget build(BuildContext context) {
    final paginationNum =
        meta.page + 6 > meta.pageCount ? meta.pageCount : meta.page + 6;
    return Wrap(
      runSpacing: 12,
      children: [
        if (meta.pageCount <= 6) ...[
          _paginationContainer(
            color: achromatic600,
            child: SvgPicture.asset('assets/common/pagination_arrow_left.svg'),
            onTap: onTap,
            onTapReturn: int.parse((meta.page - 1).toString()),
          ),
          w8,
          for (var i = 1; i < meta.pageCount + 1; i++) ...[
            _paginationContainer(
              color: meta.page == i ? primaryTeal : achromatic600,
              child: Text(
                i.toString(),
                style: body1Regular.copyWith(color: achromatic100),
              ),
              onTap: onTap,
              onTapReturn: i,
            ),
            w8,
          ],
          _paginationContainer(
            color: achromatic600,
            child: SvgPicture.asset('assets/common/pagination_arrow_right.svg'),
            onTap: onTap,
            onTapReturn: int.parse((meta.page + 1).toString()),
          ),
        ] else ...[
          _paginationContainer(
            color: achromatic600,
            child: SvgPicture.asset('assets/common/pagination_arrow_left.svg'),
            onTap: onTap,
            onTapReturn: int.parse((meta.page - 1).toString()),
          ),
          w8,
          if (meta.page != 1) ...[
            _paginationContainer(
              color: meta.page == 1 ? primaryTeal : achromatic600,
              child: Text(
                '1',
                style: body1Regular.copyWith(color: achromatic100),
              ),
              onTap: onTap,
              onTapReturn: 1,
            ),
            w8,
          ],
          if (meta.pageCount - meta.page == 1) ...[
            w4,
            SizedBox(
              height: 40,
              child: Column(
                children: [
                  h10,
                  Text(
                    '...',
                    style: body1Regular.copyWith(color: achromatic100),
                  ),
                ],
              ),
            ),
            w12,
          ],
          for (var i = meta.page; i < paginationNum; i++) ...[
            _paginationContainer(
              color: meta.page == i ? primaryTeal : achromatic600,
              child: Text(
                i.toString(),
                style: body1Regular.copyWith(color: achromatic100),
              ),
              onTap: onTap,
              onTapReturn: i.toInt(),
            ),
            w8,
          ],
          if (meta.pageCount - meta.page != 1) ...[
            w4,
            SizedBox(
              height: 40,
              child: Column(
                children: [
                  h10,
                  Text(
                    '...',
                    style: body1Regular.copyWith(color: achromatic100),
                  ),
                ],
              ),
            ),
            w12,
          ],
          _paginationContainer(
            color: meta.page == meta.pageCount ? primaryTeal : achromatic600,
            child: Text(
              meta.pageCount.toString(),
              style: body1Regular.copyWith(color: achromatic100),
            ),
            onTap: onTap,
            onTapReturn: meta.pageCount.toInt(),
          ),
          w8,
          _paginationContainer(
            color: achromatic600,
            child: SvgPicture.asset('assets/common/pagination_arrow_right.svg'),
            onTap: onTap,
            onTapReturn: int.parse((meta.page + 1).toString()),
          ),
        ],
      ],
    );
  }

  InkWell _paginationContainer({
    required Color color,
    required Widget child,
    required Function(int) onTap,
    required int onTapReturn,
  }) {
    return InkWell(
      onTap: () {
        onTap(onTapReturn);
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
