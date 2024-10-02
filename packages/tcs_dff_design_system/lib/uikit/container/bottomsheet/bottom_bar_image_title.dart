import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../image/image_widget.dart';

class BottomBarWithImageAndTitle extends StatelessWidget {
  final String? iconText;
  final VoidCallback? callback;
  final List<String>? imagePath;
  final String? imagePackage;

  BottomBarWithImageAndTitle({
    super.key,
    this.iconText,
    this.callback,
    this.imagePath,
    this.imagePackage,
  });

  @override
  Widget build(final BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width,
        color: context.theme.appColor.clrPrimaryBlue90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: context.theme.appSize.size100,
              width: context.theme.appSize.size100,
              child: Card(
                margin: EdgeInsets.all(context.theme.appSize.size5),
                elevation: context.theme.appSize.size5,
                color: context.theme.appColor.greyWhiteUi100,
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: 'images/know_more.svg',
                  package: 'uikit',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: context.theme.appSize.size5),
              child: const Text('text'),
            ),
          ],
        ),
      );
}
