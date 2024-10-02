import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';

import '../../../theme/size.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? appBarHeight;
  final Color? backgroundColor;
  final Color? backButtonColor;
  final TextEditingController controller;
  final String? hintText;
  final Function(String)? onChanged;
  final bool Function()? onBackButtonTap;

  const SearchAppBar({
    super.key,
    required this.controller,
    this.appBarHeight,
    this.backgroundColor,
    this.backButtonColor,
    this.hintText,
    this.onChanged,
    this.onBackButtonTap,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: size.size0.dp,
      backgroundColor: backgroundColor ?? color.greyWhiteUi100,
      centerTitle: false,
      titleSpacing: size.size0.dp,
      toolbarHeight: appBarHeight ?? size.size75.sp,
      leading: IconButton(
        onPressed: () {
          if (onBackButtonTap == null || !onBackButtonTap!.call()) {
            RouteNavigator.pop(context);
          }
        },
        padding: EdgeInsets.all(size.size0.dp),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: backButtonColor ?? color.clrPrimaryPurple,
          size: size.size22.sp,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(right: size.size20.dp),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: textStyle.bodyCopy2Small16Regular.copyWith(
            color: color.greyDarkGrey30,
            fontSize: size.size16.sp,
          ),
          decoration: InputDecoration(
            hintText: hintText ?? 'Search here...',
            hintStyle: textStyle.bodyCopy2Small16Regular.copyWith(
              color: color.greyDarkGrey30,
              fontSize: size.size16.sp,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: size.size4.dp,
            ),
            prefixIcon: Icon(
              Icons.search_outlined,
              size: size.size22.sp,
            ),
            prefixIconColor: color.clrPrimaryPurple,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.size6.dp),
              borderSide: BorderSide(
                color: color.greyLighterGrey70,
                width: size.size1.dp,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.size6.dp),
              borderSide: BorderSide(
                color: color.greyLighterGrey70,
                width: size.size1.dp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? AppSizes.size75.sp);
}
