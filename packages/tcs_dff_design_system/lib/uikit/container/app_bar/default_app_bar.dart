import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';

import '../../../theme/size.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final List<Widget> actions;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? backButtonColor;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final double? appBarHeight;
  final bool Function()? onBackButtonTap;

  const DefaultAppBar({
    super.key,
    required this.title,
    this.subTitle,
    this.actions = const [],
    this.showBackButton = true,
    this.backgroundColor,
    this.backButtonColor,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.appBarHeight,
    this.onBackButtonTap,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return AppBar(
      elevation: size.size0.dp,
      scrolledUnderElevation: 0.0,
      backgroundColor: backgroundColor ?? color.greyWhiteUi100,
      centerTitle: false,
      titleSpacing: size.size0.dp,
      automaticallyImplyLeading: showBackButton,
      toolbarHeight: appBarHeight ?? size.size58.sp,
      leading: showBackButton
          ? IconButton(
              onPressed: () {
                if (onBackButtonTap == null || !onBackButtonTap!.call()) {
                  RouteNavigator.pop(context);
                }
              },
              padding: subTitle != null
                  ? EdgeInsets.only(bottom: size.size20.dp)
                  : EdgeInsets.all(size.size0.dp),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: backButtonColor ?? color.clrPrimaryPurple,
                size: size.size22.sp,
              ),
            )
          : null,
      title: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: size.size20.dp,
          horizontal: showBackButton ? size.size0.dp : size.size20.dp,
        ),
        title: Text(
          title,
          style: titleTextStyle ??
              textStyle.h218pxbold.copyWith(
                fontSize: size.size18.sp,
              ),
        ),
        subtitle: subTitle != null
            ? Text(
                subTitle!,
                style: subTitleTextStyle ??
                    textStyle.h414pxRegular.copyWith(
                      fontSize: size.size14.sp,
                      color: color.clrPrimaryBlue40,
                    ),
              )
            : null,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? AppSizes.size58.sp);
}
