import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/masker/masker.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class TextWidgetMasking extends StatefulWidget {
  const TextWidgetMasking({
    super.key,
    required this.customPattern,
    required this.text,
    this.textStyle,
    this.iconColor,
    this.iconSize,
  });

  final String text;
  final String customPattern;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double? iconSize;

  @override
  State<TextWidgetMasking> createState() => _TextWidgetMaskingState();
}

class _TextWidgetMaskingState extends State<TextWidgetMasking> {
  bool maskText = true;

  void setMaskText() {
    setState(() {
      maskText = !maskText;
    });
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            maskText == true
                ? Masker.doMask(
                    originalText: widget.text.replaceAll(',', ''),
                    maskType: MaskTypes.custom,
                    customPattern: widget.customPattern,
                  )
                : widget.text,
            style: widget.textStyle ??
                textStyle.bodyCopy2Large16Bold.copyWith(
                  color: color.greyBlackUi10,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Container(
            margin: EdgeInsets.only(left: size.size4.dp),
            child: InkWell(
              onTap: setMaskText,
              child: Icon(
                !maskText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: widget.iconColor ?? color.clrPrimaryPurple30,
                size: widget.iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
