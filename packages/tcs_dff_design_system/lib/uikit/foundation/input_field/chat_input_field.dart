import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback onPress;
  final Color? textColor;
  final bool focused;
  final FocusNode? focusNode;
  final bool enabled;
  final Function(String)? onChanged;

  const ChatInputField({
    super.key,
    this.controller,
    required this.hintText,
    this.textColor,
    this.focused = false,
    this.focusNode,
    this.enabled = true,
    this.onChanged,
    required this.onPress,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.size27.dp),
      child: Container(
        color: color.greyWhiteUi100,
        child: Padding(
          padding: EdgeInsets.only(left: size.size20.dp),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: textColor != null
                ? textStyle.h414pxRegular.copyWith(
                    color: textColor,
                  )
                : textStyle.h414pxRegular,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              suffixIcon: InkWell(
                onTap: onPress,
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: 'assets/images/send.svg',
                  package: 'tcs_dff_design_system',
                ),
              ),
            ),
            autofocus: focused,
            focusNode: focusNode,
            enabled: enabled,
            onChanged: (final text) {
              if (onChanged != null) {
                onChanged!(text);
              }
            },
          ),
        ),
      ),
    );
  }
}
