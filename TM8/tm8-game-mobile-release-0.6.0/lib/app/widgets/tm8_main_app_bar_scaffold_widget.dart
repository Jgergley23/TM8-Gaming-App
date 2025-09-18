import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class Tm8MainAppBarScaffoldWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const Tm8MainAppBarScaffoldWidget({
    super.key,
    required this.title,
    required this.leading,
    this.action,
    this.actionIcon,
    this.onActionPressed,
    this.onTitlePressed,
    this.titleIcon,
    this.titleIconWidget,
    this.actionPadding = const EdgeInsets.only(right: 12),
    this.navigationPadding = EdgeInsets.zero,
    this.leadingColor,
    this.secondIcon,
    this.onSecondIconPressed,
    this.focusNode,
  });

  final String title;
  final Widget? actionIcon;
  final bool leading;
  final bool? action;
  final bool? titleIcon;
  final Widget? titleIconWidget;
  final Widget? secondIcon;
  final VoidCallback? onActionPressed;
  final VoidCallback? onTitlePressed;
  final EdgeInsetsGeometry actionPadding;
  final EdgeInsetsGeometry navigationPadding;
  final Color? leadingColor;
  final VoidCallback? onSecondIconPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: navigationPadding,
      child: AppBar(
        centerTitle: true,
        toolbarHeight: 32,
        leadingWidth: 32,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: leading
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  if (focusNode != null) {
                    focusNode!.unfocus();
                  }
                  context.maybePop();
                },
                child: Container(
                  height: 32,
                  width: 32,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: leadingColor ?? achromatic500,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.common.navigationBackArrow.path,
                    ),
                  ),
                ),
              )
            : null,
        title: titleIcon != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  titleIconWidget!,
                  w8,
                  GestureDetector(
                    onTap: () {
                      if (onTitlePressed != null) onTitlePressed!();
                    },
                    child: Text(
                      title,
                      style: heading4Regular.copyWith(
                        color: achromatic200,
                      ),
                    ),
                  ),
                ],
              )
            : GestureDetector(
                onTap: () {
                  if (onTitlePressed != null) onTitlePressed!();
                },
                child: Text(
                  title,
                  style: heading4Regular.copyWith(
                    color: achromatic200,
                  ),
                ),
              ),
        actions: action != null
            ? [
                secondIcon != null
                    ? GestureDetector(
                        onTap: onSecondIconPressed,
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
                            child: secondIcon!,
                          ),
                        ),
                      )
                    : Container(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onActionPressed,
                  child: SizedBox(
                    width: 64,
                    child: Stack(
                      children: [
                        Center(
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
                              child: actionIcon!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
