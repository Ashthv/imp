import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';

import '../../../theme/size.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/text_widget.dart';

class IconSubSectionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<String>? titleStyledTextList;
  final List<Widget> subSections;
  final List<Widget> actions;
  final bool showBackButton;
  final Widget leadingIcon;
  final Size? leadingIconSize;
  final double? appBarHeight;
  final Color? backgroundColor;
  final Color? backButtonColor;
  final TextStyle? titleTextStyle;
  final TextStyle? titleStyledTextStyle;
  final bool Function()? onBackButtonTap;

  const IconSubSectionAppBar({
    super.key,
    required this.title,
    this.titleStyledTextList,
    this.subSections = const [],
    this.actions = const [],
    this.showBackButton = true,
    required this.leadingIcon,
    this.leadingIconSize,
    this.appBarHeight,
    this.backgroundColor,
    this.backButtonColor,
    this.titleTextStyle,
    this.titleStyledTextStyle,
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
      toolbarHeight: appBarHeight ?? size.size78.sp,
      leading: showBackButton
          ? IconButton(
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
            )
          : null,
      title: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: size.size20.dp,
          horizontal: showBackButton ? size.size0.dp : size.size20.dp,
        ),
        horizontalTitleGap: size.size8.dp,
        leading: SizedBox.fromSize(
          size: leadingIconSize ??
              Size(
                size.size46.sp,
                size.size46.sp,
              ),
          child: leadingIcon,
        ),
        title: TextWidget(
          text: title,
          style: titleTextStyle ??
              (subSections.isEmpty
                  ? textStyle.h218pxbold.copyWith(
                      fontSize: size.size18.sp,
                    )
                  : textStyle.labelSmall14Medium.copyWith(
                      fontSize: size.size14.sp,
                      color: color.greyBlackUi10,
                    )),
          styledTextList: titleStyledTextList,
          styledTextStyle: titleStyledTextStyle,
        ),
        subtitle: subSections.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: subSections,
              )
            : null,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? AppSizes.size78.sp);
}
