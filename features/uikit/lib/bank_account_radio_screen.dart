import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class BankAccountRadioButtonScreen extends StatefulWidget {
  const BankAccountRadioButtonScreen({super.key});

  @override
  State<BankAccountRadioButtonScreen> createState() =>
      BankAccountRadioButtonScreenState();
}

class BankAccountRadioButtonScreenState
    extends State<BankAccountRadioButtonScreen> {
  bool yesSelected = true;
  bool noSelected = false;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.size15.dp),
              BankAccountRadioButton(
                title: 'SBI Bank 5678',
                subTitle: 'Savings Account ',
                hyperLinkBtn: HyperlinkButton(
                  caption: 'check balance',
                  onPressed: () {},
                ),
                onChanged: (final value) {
                  setState(() {
                    if (!value) {
                      yesSelected = !yesSelected;
                      noSelected = !noSelected;
                    }
                  });
                },
                isSelected: yesSelected,
                leadingImagePath: 'images/axis_bank_icn.png',
                package: 'uikit',
              ),
              SizedBox(height: context.theme.appSize.size15.dp),
              BankAccountRadioButton(
                title: 'AXIS Bank 7656',
                subTitle: 'Savings Account ',
                onChanged: (final value) {
                  setState(() {
                    if (!value) {
                      noSelected = !noSelected;
                      yesSelected = !yesSelected;
                    }
                  });
                },
                isSelected: noSelected,
                leadingImagePath: 'images/axis_bank_icn.png',
                package: 'uikit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
