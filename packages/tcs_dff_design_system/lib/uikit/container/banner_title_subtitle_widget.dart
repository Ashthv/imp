import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';
import '../foundation/text_widget.dart';

class BannerTitleSubtitleWidget extends StatelessWidget {
  final String? thumbnailLink;
  final String title;
  final TextStyle? titleStyle;
  final String subTitle;
  final TextStyle? subTitleStyle;
  final VoidCallback callback;
  const BannerTitleSubtitleWidget({
    super.key,
    this.thumbnailLink,
    required this.title,
    required this.subTitle,
    required this.callback,
    this.subTitleStyle,
    this.titleStyle,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          InkWell(
            onTap: callback,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: thumbnailLink != null
                  ? Container(
                      child: Image.network(thumbnailLink!),
                      // use designSystem component, some issues component
                      // hence temp using flutter's widget
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            color.clrPrimaryPurple,
                            color.clrPrimaryPink,
                          ],
                        ),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.size10.dp,
              horizontal: size.size20.dp,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  style: titleStyle ?? theme.textTheme.headlineSmall!,
                ),
                SizedBox(
                  height: size.size5.dp,
                ),
                TextWidget(
                  text: subTitle,
                  style: subTitleStyle ?? theme.textTheme.labelMedium!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
