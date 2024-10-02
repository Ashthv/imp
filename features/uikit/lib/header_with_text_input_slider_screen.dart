import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class HeaderWithTextInputSliderScreen extends StatefulWidget {
  const HeaderWithTextInputSliderScreen({
    super.key,
  });

  @override
  State<HeaderWithTextInputSliderScreen> createState() =>
      _HeaderWithTextInputWithSliderState();
}

class _HeaderWithTextInputWithSliderState
    extends State<HeaderWithTextInputSliderScreen> {
  late int sliderValue;

  TextEditingController controller = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController rateOfInterest = TextEditingController();

  @override
  void initState() {
    sliderValue = 0;
    super.initState();
    controller.text = '900000';
    monthController.text = '15';
    rateOfInterest.text = '12.5';
  }

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWithTextInputWithSlider(
              titleText: locale.txt(key: 'loanAmountText'),
              controller: controller,
              minValue: 100000,
              maxValue: 1390000,
              sliderDivision: 100,
              prefix: '₹ ',
              inputFormatType: 'number',
              onChange: (final value) {
                setState(() {
                  controller.text = value;
                });
              },
            ),
            HeaderWithTextInputWithSlider(
              titleText: locale.txt(key: 'loanAmountText'),
              controller: monthController,
              minValue: 06,
              maxValue: 72,
              sliderDivision: 66,
              suffix: 'months',
              onChange: (final value) {
                setState(() {
                  monthController.text = value;
                });
              },
            ),
            HeaderWithTextInputWithSlider(
              titleText: locale.txt(key: 'loanAmountText'),
              controller: rateOfInterest,
              minValue: 10,
              maxValue: 14,
              sliderDivision: 10,
              suffix: '%',
              inputFormatType: 'double',
              inputLength: 5,
              onChange: (final value) {
                setState(() {
                  rateOfInterest.text = value;
                });
              },
            ),
            TextWidget(
              text: 'TOTAL EMI ${totalPay()}',
            ),
          ],
        ),
      ),
    );
  }

  String totalPay() {
    var totalPayment = 0;
    setState(() {
      if (controller.text.isNotEmpty &&
          monthController.text.isNotEmpty &&
          rateOfInterest.text.isNotEmpty) {
        final amount = int.parse(controller.text.replaceAll(',', ''));
        final months = int.parse(monthController.text);
        final interest = double.parse(rateOfInterest.text);

        final n = months * 12;
        final r = (interest / 100) / 12;
        final _monthlyEMI = (amount * r * pow(1 + r, n)) / (pow(1 + r, n) - 1);
        totalPayment = (_monthlyEMI * n.toDouble()).round();
      }
    });
    return totalPayment.toString();
  }
}
