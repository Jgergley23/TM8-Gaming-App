// ignore_for_file: deprecated_member_use_from_same_package
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/notifications/logic/slidable_controller_cubit/slidable_controller_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

class NotificationItemWidget extends StatefulWidget {
  const NotificationItemWidget({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final NotificationResponse notification;
  final VoidCallback onTap;

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget>
    with SingleTickerProviderStateMixin {
  late final SlidableController slidableController;

  @override
  void initState() {
    super.initState();
    slidableController = SlidableController(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<SlidableControllerCubit>(),
      child: BlocListener<SlidableControllerCubit, bool>(
        listener: (context, state) {
          slidableController.close();
        },
        child: Container(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Slidable(
            groupTag: 'tag${widget.notification.id}',
            controller: slidableController,
            dragStartBehavior: DragStartBehavior.start,
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                CustomSlidableAction(
                  onPressed: (context) {
                    widget.onTap();
                  },
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  backgroundColor: errorColor,
                  child: Assets.common.delete.svg(
                    width: 20,
                    height: 20,
                    color: achromatic800,
                  ),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: achromatic600,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.notification.data.title,
                        style: body1Regular.copyWith(
                          color: achromatic100,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (!widget.notification.data.isRead)
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 180,
                        child: Text(
                          widget.notification.data.description,
                          style: body2Regular.copyWith(
                            color: achromatic200,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        formatedTimePassed(
                          widget.notification.createdAt,
                        ),
                        style: captionRegular.copyWith(
                          color: achromatic200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatedTimePassed(DateTime dateTime) {
    var returnable = '';

    final now = DateTime.now();
    final time = now.difference(dateTime);

    if (time.inDays <= 0) {
      if (time.inHours <= 0) {
        returnable = '${time.inMinutes} min ago';
      } else {
        final minutes = time.inMinutes % (60 * time.inHours);
        if (time.inHours == 1) {
          returnable = '${time.inHours} hour and $minutes min ago';
        } else {
          returnable = '${time.inHours} hours and $minutes min ago';
        }
      }
    } else {
      if (time.inDays == 1) {
        returnable = '${time.inDays} day ago';
      } else {
        returnable = '${time.inDays} days ago';
      }
    }

    return returnable;
  }
}
