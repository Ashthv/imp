import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/masker/masker.dart';

import '../../tcs_dff_design_system.dart';
import '../../theme/theme.dart';
import '../../theme/theme_extensions/color_extension.dart';
import '../../theme/theme_extensions/size_extension.dart';
import '../../theme/theme_extensions/text_style_extension.dart';
import '../../utils/sizer/app_sizer.dart';

class TitleSubtitleTextWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleTextStyle, subtitleTextStyle;
  final String? customPattern;
  final bool verticalOrientation;
  final DividerLine? dividerLine;
  final int titleFlex;
  final int subTitleFlex;

  const TitleSubtitleTextWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.customPattern,
    this.verticalOrientation = true,
    this.dividerLine,
    this.titleFlex = 1,
    this.subTitleFlex = 1,
  });

  @override
  State<TitleSubtitleTextWidget> createState() =>
      _TitleSubtitleTextWidgetState();
}

class _TitleSubtitleTextWidgetState extends State<TitleSubtitleTextWidget> {
  bool maskText = true;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return Container(
      child: widget.verticalOrientation
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: buildTitleText(textStyle, color, size),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.size4.dp,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: buildSubtitleText(textStyle, color, size),
                    ),
                    if (widget.customPattern != null)
                      Container(
                        margin: EdgeInsets.only(left: size.size4.dp),
                        child: InkWell(
                          onTap: setMaskText,
                          child: Icon(
                            maskText
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: color.clrPrimaryPurple30,
                          ),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
                buildDividerLine(size),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: widget.titleFlex,
                      child: buildTitleText(textStyle, color, size),
                    ),
                    Expanded(
                      flex: widget.subTitleFlex,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: buildSubtitleText(textStyle, color, size),
                      ),
                    ),
                  ],
                ),
                buildDividerLine(size),
              ],
            ),
    );
  }

  Widget buildTitleText(
    final AppTextStyleExtension textStyle,
    final AppColorsExtension color,
    final AppSizeExtension size,
  ) =>
      Text(
        widget.title,
        style: (widget.titleTextStyle != null)
            ? widget.titleTextStyle
            : textStyle.labelSmall14Medium.copyWith(
                color: color.greyDarkestGrey20,
                fontWeight: FontWeight.w400,
                fontSize: size.size14.dp,
              ),
      );

  Widget buildSubtitleText(
    final AppTextStyleExtension textStyle,
    final AppColorsExtension color,
    final AppSizeExtension size,
  ) =>
      Text(
        widget.customPattern != null && maskText == true
            ? Masker.doMask(
                originalText: widget.subtitle,
                maskType: MaskTypes.custom,
                customPattern: widget.customPattern!,
              )
            : widget.subtitle,
        style: (widget.subtitleTextStyle != null)
            ? widget.subtitleTextStyle
            : textStyle.bodyCopy2Medium16SemiBold.copyWith(
                fontWeight: FontWeight.w600,
                color: color.greyBlackUi10,
                fontSize: size.size16.dp,
              ),
      );

  void setMaskText() {
    setState(() {
      maskText = !maskText;
    });
  }

  Widget buildDividerLine(final AppSizeExtension size) {
    if (widget.dividerLine != null) {
      return Container(
        margin: EdgeInsets.only(top: size.size8.dp),
        child: widget.dividerLine,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
