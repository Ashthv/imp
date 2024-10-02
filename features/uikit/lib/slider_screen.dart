import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/amount_textfield.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/currency_formatter.dart';
import 'package:tcs_dff_design_system/uikit/foundation/range_slider_widget.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  late int sliderValue;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    sliderValue = 0;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AmountTextField(
                label: 'Amount Field',
                controller: controller,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  CurrencyInputFormatter(),
                ],
                onChanged: (final text) {
                  if (text.isNotEmpty) {
                    final inputValue =
                        double.parse(text.replaceAll(',', '')).round();
                    sliderValue = inputValue <= 2500000 ? inputValue : 2500000;
                  } else {
                    sliderValue = 0;
                  }
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RangeSliderWidget(
                minValue: 0,
                maxValue: 2500000,
                division: 2500,
                initialSliderValue: sliderValue.roundToDouble(),
                selectedSliderValue: (final value) {
                  setState(() {
                    sliderValue = value;
                    controller.text = NumberFormat('#,##,##,###').format(value);
                  });
                },
              ),
            ),
          ],
        ),
      );
}
