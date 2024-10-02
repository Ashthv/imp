import 'package:flutter/material.dart';
 
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
 
class TextIconCard extends StatelessWidget {
  final String imagePath;
  final String imageText;
  final void Function()? onTap;
  const TextIconCard({
    super.key,
    required this.imagePath,
    required this.onTap,
    required this.imageText,
  });
 
  @override
  Widget build(final BuildContext context) => InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Image.asset(
              imagePath,
            ),
            SizedBox(
              height: context.theme.appSize.size5.sp,
            ),
            Text(
              imageText,
              style: context.theme.textTheme.displayMedium!.copyWith(
                    fontSize: context.theme.appSize.size15.sp,
                    color: context.theme.appColor.clrPrimaryPurple,
                  ),
            ),
          ],
        ),
      );
}