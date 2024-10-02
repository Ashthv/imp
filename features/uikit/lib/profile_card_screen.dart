import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/masker/masker.dart';

class ProfileCardScreen extends StatelessWidget {
  const ProfileCardScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final appTextStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ProfileCard(
              title: 'Jane Doe',
              subtitle: '+91 - XXXXXXXXXX',
              profileCardType: ProfileCardType.mobile,
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            const ProfileCard(
              title: 'Jane Doe',
              subtitle: '+91 - XXXXXXXXXX',
              infoText: 'rent',
              profileCardType: ProfileCardType.infoText,
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            ProfileCard(
              title: 'Jane Doe',
              profileCardType: ProfileCardType.defaultValue,
              titleTextStyle: appTextStyle.detailsSmall12Regular.copyWith(
                color: color.greyBlackUi10,
                fontWeight: FontWeight.w400,
                fontSize: size.size12.dp,
              ),
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            const ProfileCard(
              title: 'Jane Doe',
              subtitle: 'sm95cr7@sbi',
              profileCardType: ProfileCardType.email,
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            ProfileCard(
              imageType: ImageType.networkImage,
              title: 'Account Number',
              subtitle: Masker.doMask(
                originalText: '1234567890123999',
                maskType: MaskTypes.custom,
                customPattern: 'xxxx xxxx xxxx ####',
                maskedSymbol: 'x',
              ),
              profileCardType: ProfileCardType.accountNo,
              placeholderImagePath: 'images/dummy_img.jpg',
              package: 'uikit',
              imagePath:
                  'https://th.bing.com/th?id=OIP.TX7VOHY2KLFt3OcfpnV3HgHaH-&w=240&h=259&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
              titleTextStyle: appTextStyle.bodyCopy3Small14Regular.copyWith(
                color: color.greyBlackUi10,
              ),
            ),
            SizedBox(
              height: size.size1.dp,
            ),
            const ProfileCard(
              imageType: ImageType.assetImage,
              title: 'Apollo Pharmacy',
              subtitle: 'apollopharma@ybl',
              imagePath: 'images/dummy_img.jpg',
              package: 'uikit',
              profileCardType: ProfileCardType.image,
            ),
          ],
        ),
      ),
    );
  }
}
