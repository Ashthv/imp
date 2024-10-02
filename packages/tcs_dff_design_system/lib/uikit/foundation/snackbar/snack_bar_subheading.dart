import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class SnackBarSubheading extends StatelessWidget {
  final String notificationType;
  final bool isHelpIcon;
  final Color colorSecondary;
  final String descriprionText;

  const SnackBarSubheading({
    super.key,
    required this.descriprionText,
    required this.isHelpIcon,
    required this.notificationType,
    required this.colorSecondary,
  });
  @override
  Widget build(final BuildContext context) => Container(
        padding: EdgeInsets.all(context.theme.appSize.size16.dp),
        decoration: BoxDecoration(
          color: colorSecondary,
          borderRadius: BorderRadius.circular(context.theme.appSize.size10.dp),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Visibility(
                visible: isHelpIcon,
                child: Icon(
                  Icons.info_outline,
                  color: context.theme.appColor.greyFullWhite120,
                ),
              ),
            ),
            SizedBox(
              width: context.theme.appSize.size8.dp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    notificationType,
                    style:
                        context.theme.appTextStyles.labelSmall18Medium.copyWith(
                      color: context.theme.appColor.greyFullWhite120,
                      fontSize: context.theme.appSize.size20.sp,
                    ),
                  ),
                  SizedBox(height: context.theme.appSize.size8.dp),
                  Text(
                    descriprionText,
                    style: context.theme.appTextStyles.bodyCopy2Small16Regular
                        .copyWith(
                      color: context.theme.appColor.greyFullWhite120,
                      fontSize: context.theme.appSize.size16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.close,
                color: context.theme.appColor.greyFullWhite120,
              ),
            ),
          ],
        ),
      );
}
