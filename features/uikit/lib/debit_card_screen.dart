import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/Container/card/debit_card.dart';
import 'package:tcs_dff_design_system/uikit/container/card/physical_debit_card.dart';
import 'package:tcs_dff_design_system/utils/image_type.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class DebitCardScreen extends StatelessWidget {
  const DebitCardScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(size.size8.dp),
            child: DebitCard(
              backgroundImagePath: 'images/Design1.png',
              cardName: 'Rupay',
              cardTypeImagePath: 'images/Vector.png',
              package: 'uikit',
              cardHolderName: 'Rahul Anil sharma',
              cardNumber: '1234 5678 1234 5678',
              cvv: '123',
              expiryDate: '12/23',
              cardTypeNote: 'Physical Card',
              imageType: ImageType.assetImage,
              expiryTitle: 'Expiry Date',
              cvvTitle: 'CVV',
            ),
          ),
          Container(
            padding: EdgeInsets.all(size.size8.dp),
            height: MediaQuery.of(context).size.height * 0.29,
            child: PhysicalDebitCard(
              cardHolderName: 'Rahul Anil Sharma',
              backgroundImagePath: 'images/Design1.png',
              cardTypeNote: 'Physical Card',
              package: 'uikit',
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
