import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';

import '../../../theme/theme.dart';
import '../../../utils/dropdown_menue_model.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../image/image_widget.dart';

class DropdownBottomsheetListTile extends StatelessWidget {
  final List<DropdownMenuModel> items;
  final int i;
  final Function(DropdownMenuModel) onItemSelect;

  const DropdownBottomsheetListTile({
    required this.items,
    required this.i,
    required this.onItemSelect,
  });

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: size.size21.dp,
        vertical: size.size12.dp,
      ),
      leading: items[i].imagePath == null || items[i].imagePath!.isEmpty
          ? null
          : Container(
              clipBehavior: Clip.hardEdge,
              height: size.size41.dp,
              width: size.size41.dp,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ImageWidget(
                imageType: ImageType.assetImage,
                path: items[i].imagePath!,
                package: items[i].imagePackage!,
                fit: BoxFit.fill,
              ),
            ),
      title: Text(
        items[i].title,
        style: textStyle.bodyCopy1Small18Regular.copyWith(
          color: color.greyWhiteUi100,
          fontSize: size.size18.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: items[i].subtitle == null
          ? null
          : Text(
              items[i].subtitle!,
              style: textStyle.h414pxRegular.copyWith(
                color: color.greyWhiteUi100,
                fontSize: size.size14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
      onTap: () {
        onItemSelect(items[i]);
        RouteNavigator.popDialog(context);
      },
    );
  }
}
