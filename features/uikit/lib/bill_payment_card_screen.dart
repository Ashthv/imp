import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/card/bill_payment_card.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.size20.dp,
          vertical: size.size20.dp,
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.size277.dp,
              height: size.size134.dp,
              child: BillPaymentCard(
                consumerName: 'Omkar Hande',
                consumerNumber: 'CA: 010929384034343',
                billType: 'Mahanagar Electricity',
                buttonText: 'Electricity',
                imagePath: [
                  'images/bp_bg.svg',
                  'images/biller_image.png',
                  'images/keyboard_arrow_right.svg',
                ],
                imagePackage: 'uikit',
                buttonBackgroundColor: color.greyWhiteUi100.withOpacity(0.25),
                payNowText: 'Pay Now',
                iconBorderColor: color.clrPrimaryBlue50,
                iconWidthColor: color.clrPrimaryBlue,
              ),
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            SizedBox(
              width: size.size277.dp,
              height: size.size134.dp,
              child: BillPaymentCard(
                consumerName: 'Omkar Hande',
                consumerNumber: 'CA: 010929384034343',
                billType: 'Mahanagar Electricity',
                buttonText: 'Mobile Recharge',
                imagePath: [
                  'images/bp_bg1.svg',
                  'images/biller_image.png',
                  'images/keyboard_arrow_right.svg',
                ],
                imagePackage: 'uikit',
                buttonBackgroundColor: color.greyWhiteUi100.withOpacity(0.25),
                payNowText: 'Pay Now',
                iconBorderColor: color.clrPrimaryPink50,
                iconWidthColor: color.clrPrimaryPink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
