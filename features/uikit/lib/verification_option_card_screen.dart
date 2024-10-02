import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/card/verification_option_card.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class VerificationOptionCardScreen extends StatelessWidget {
  const VerificationOptionCardScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Container(
      margin: EdgeInsets.only(
        left: size.size20.dp,
        right: size.size26.dp,
      ),
      child: Column(
        children: [
          VerificationOptionCard(
            title: 'Debit Card',
            subTitle: 'Verify through any one of your debit cards',
            imagePath: 'images/verification_option_card.png',
            // isEnabled: true,
            isSelected: true,
            imagePackage: 'uikit',
            onTap: () {},
          ),
          SizedBox(
            height: size.size20.dp,
          ),
          VerificationOptionCard(
            title: 'Debit Card',
            subTitle: 'Verify through any one of your debit cards',
            imagePath: 'images/verification_option_card.png',
            // isEnabled: true,
            // isSelected: false,
            imagePackage: 'uikit',
            onTap: () {},
          ),
          SizedBox(
            height: size.size20.dp,
          ),
          VerificationOptionCard(
            title: 'Debit Card',
            // subTitle: 'Verify through any one of your debit cards',
            imagePath: 'images/verification_option_card.png',
            isEnabled: false,
            // isSelected: false,
            imagePackage: 'uikit',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
