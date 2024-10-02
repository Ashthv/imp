import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../foundation/text_widget.dart';

class BadgeWidget extends StatelessWidget {
  final String? title;
  final int? notificationCount;
  BadgeWidget({super.key, this.notificationCount, this.title});
  @override
  Widget build(final BuildContext context) => Badge(
        backgroundColor: context.theme.appColor.clrPrimaryPink,
        offset: const Offset(7, -6),
        label: notificationCount == null
            ? null
            : Text(
                notificationCount.toString(),
                style:
                    context.theme.appTextStyles.detailsSmall12Regular.copyWith(
                  color: context.theme.appColor.greyWhiteUi100,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
        child: title != null
            ? TextWidget(
                text: title!,
                style: context.theme.appTextStyles.h316pxsemiBold.copyWith(
                  color: context.theme.appColor.clrPrimaryPurple,
                  fontWeight: FontWeight.w600,
                ),
              )
            : Icon(
                Icons.notifications_outlined,
                color: context.theme.appColor.clrPrimaryPurple,
              ),
      );
}
