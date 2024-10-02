import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final bankCardList = [
    BankCardModel(
      cardType: 'Visa Card',
      cardName: 'Platinum',
      cardNumber: '4536 2596 83••• •••',
      cardHolderName: 'Pratik Patil',
      accountNo: 'Acc No: XXXXXXXXXXX2967',
      cardTypeImagePath: 'images/Vector.png',
      backgroundImagePath: 'images/Design1.png',
      package: 'uikit',
      isFaded: false,
    ),
    BankCardModel(
      cardType: 'Visa Card',
      cardName: 'Platinum',
      cardNumber: '4536 2596 83••• •••',
      cardHolderName: 'Pratik Patil',
      accountNo: 'Acc No: XXXXXXXXXXX2967',
      cardTypeImagePath: 'images/Vector.png',
      backgroundImagePath: 'images/Design1.png',
      package: 'uikit',
      isFaded: false,
    ),
    BankCardModel(
      cardType: 'Visa Card',
      cardName: 'Platinum',
      cardNumber: '4536 2596 83••• •••',
      cardHolderName: 'Pratik Patil',
      accountNo: 'Acc No: XXXXXXXXXXX2967',
      cardTypeImagePath: 'images/Vector.png',
      backgroundImagePath: 'images/Design1.png',
      package: 'uikit',
      isFaded: false,
    ),
    BankCardModel(
      cardType: 'Visa Card',
      cardName: 'Platinum',
      cardNumber: '4536 2596 83••• •••',
      cardHolderName: 'Pratik Patil',
      accountNo: 'Acc No: XXXXXXXXXXX2967',
      cardTypeImagePath: 'images/Vector.png',
      backgroundImagePath: 'images/Design1.png',
      package: 'uikit',
      isFaded: false,
    ),
  ];
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(size.size20.dp),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: bankCardList.length,
          itemBuilder: (final BuildContext context, final index) => Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.size5.dp,
            ),
            child: InkWell(
              onTap: () {
                for (var i = 0; i < bankCardList.length; i++) {
                  if (index != i) {
                    setState(() {
                      bankCardList[index].isFaded = false;
                      bankCardList[i].isFaded = true;
                    });
                  }
                }
              },
              child: BankCard(
                cardType: bankCardList[index].cardType,
                cardName: bankCardList[index].cardName,
                cardNumber: bankCardList[index].cardNumber,
                cardHolderName: bankCardList[index].cardHolderName,
                accountNo: bankCardList[index].accountNo,
                backgroundImagePath: bankCardList[index].backgroundImagePath,
                cardTypeImagePath: bankCardList[index].cardTypeImagePath,
                isFaded: bankCardList[index].isFaded,
                package: bankCardList[index].package,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
