import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../utils/image_type.dart';
import '../../utils/sizer/app_sizer.dart';
import 'image/image_widget.dart';

class FooterNoteWidget extends StatelessWidget {
  final String title;
  final String? trailingImage;
  final String? leadingImage;
  final VoidCallback onpressed;
  final String? package;
  const FooterNoteWidget({
    super.key,
    required this.title,
    this.trailingImage,
    this.leadingImage,
    required this.package,
    required this.onpressed,
  });

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.size21.dp,
        vertical: size.size6.dp,
      ),
      decoration: BoxDecoration(
        color: color.clrPrimaryBlue110,
      ),
      child: Row(
        children: [
          if (leadingImage != null)
            Padding(
              padding:  EdgeInsets.only(right: size.size4.dp),
              child: InkWell(
                onTap:onpressed,
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: leadingImage!,
                  package: package,
                  
                ),
              ),
            ),
          Expanded(
            child: Text(
              title,
              style: context.theme.appTextStyles.h316pxsemiBold.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: context.theme.appSize.size16.dp,
                color: context.theme.appColor.clrPrimaryPurple20,
              ),
            ),
          ),
          
          if (trailingImage != null)
            Padding(
              padding:  EdgeInsets.only(right: size.size4.dp),
              child: InkWell(
                onTap:onpressed,
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: trailingImage!,
                  package: package,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
