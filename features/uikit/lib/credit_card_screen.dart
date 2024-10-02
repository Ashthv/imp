import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/credit_card_type.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/masker/masker.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  CreditCardStatus creditCardStatus1 = CreditCardStatus.active;
  CreditCardStatus creditCardStatus2 = CreditCardStatus.inactive;
  CreditCardStatus creditCardStatus3 = CreditCardStatus.blocked;
  bool isReissuranceApplied = false;
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.size20.dp,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CreditCard(
              cardName: 'SBI Card',
              cardNumber: Masker.doMask(
                originalText: '1234123412341728',
                maskType: MaskTypes.creditCard,
              ),
              backgroundColor: context.theme.appColor.clrPrimaryBlue,
              bgImagePath: 'images/coins.png',
              bgImagePackage: 'uikit',
              outStandingText: 'Current Outstanding\nAs of ',
              outstandingDate: '11 DEC 2023',
              outStandingAmount: '₹ 0.00',
              buttonTextActivate: 'Activate Now',
              creditCardStatus: creditCardStatus1,
              isDisabled: true,
            ),
            CreditCard(
              cardName: 'SBI Card',
              cardNumber: Masker.doMask(
                originalText: '1234123412341728',
                maskType: MaskTypes.creditCard,
              ),
              backgroundColor: context.theme.appColor.clrPrimaryBlue,
              bgImagePath: 'images/coins.png',
              bgImagePackage: 'uikit',
              outStandingText: 'Current Outstanding\nAs of ',
              outstandingDate: '11 DEC 2023',
              outStandingAmount: '₹ 0.00',
              buttonTextActivate: 'Activate Now',
              creditCardStatus: creditCardStatus2,
              onPressedActivate: () {
                setState(() {
                  creditCardStatus2 = CreditCardStatus.active;
                });
              },
            ),
            CreditCard(
              cardName: 'SBI Card',
              cardNumber: Masker.doMask(
                originalText: '1234123412341728',
                maskType: MaskTypes.creditCard,
              ),
              backgroundColor: context.theme.appColor.clrPrimaryBlue,
              bgImagePath: 'images/coins.png',
              bgImagePackage: 'uikit',
              outStandingText: 'Current Outstanding\nAs of ',
              outstandingDate: '11 DEC 2023',
              outStandingAmount: '₹ 0.00',
              buttonTextActivate: 'Activate Now',
              creditCardStatus: creditCardStatus3,
              isReissuranceApplied: isReissuranceApplied,
              cardBlockedText: 'Card Blocked ',
              reIssuanceText: 'Applied for Re-issuance',
              cardBlockedStatusImagePath: 'images/cardBlockedStatusIcon.svg',
              cardBlockedStatusImagePackage: 'uikit',
              reinsuranceStatusImagePath: 'images/reinsuranceStatusIcon.svg',
              reinsuranceStatusImagePackage: 'uikit',
              onPressedReissue: () {
                setState(() {
                  isReissuranceApplied = true;
                });
              },
              buttonTextReissue: 'Reissue',
            ),
          ],
        ),
      ),
    );
  }
}
