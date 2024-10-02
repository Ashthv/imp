import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/image/image_widget.dart';
import 'package:tcs_dff_design_system/utils/image_type.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class ImageryScreen extends StatelessWidget {
  const ImageryScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ImageWidget(
              imageType: ImageType.assetImage,
              path: 'images/coins.png',
              package: 'uikit',
            ),
            SizedBox(
              width: size.size20.dp,
            ),
            ImageWidget(
              imageType: ImageType.assetImage,
              path: 'images/check_status.svg',
              package: 'uikit',
            ),
             SizedBox(
              width: size.size20.dp,
            ),
            ImageWidget(
              imageType: ImageType.networkImage,
              placeholderImagePath: 'images/placeholder.jpg',
              package: 'uikit',
              path:
                  'https://th.bing.com/th?id=OIP.TX7VOHY2KLFt3OcfpnV3HgHaH-&w=240&h=259&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
            ),
          ],
        ),
      ),
    );
  }
}
