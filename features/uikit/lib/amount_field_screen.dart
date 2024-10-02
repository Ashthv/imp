import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/amount_textfield.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/currency_formatter.dart';
import 'package:tcs_dff_design_system/uikit/foundation/text_widget.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class AmountFieldScreen extends StatefulWidget {
  const AmountFieldScreen({super.key});

  @override
  State<AmountFieldScreen> createState() => _AmountFieldScreenState();
}

class _AmountFieldScreenState extends State<AmountFieldScreen> {
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      amountController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return AmountTextField(
      label: 'Amount',
      controller: amountController,
      textFieldtypeText: 'Optional',
      helperWidget: Text(
        'Helper Text',
        style: textStyle.labelSmall14Medium.copyWith(
          fontSize: size.size14.sp,
          fontWeight: FontWeight.w400,
          color: color.clrPrimaryBlue,
        ),
      ),
      // maxLength: 8,
      // be moved inside of component or not
      inputFormatters: [
        // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),  //Input without decimal
        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
        CurrencyInputFormatter(),
      ],
      prefixWidget: const TextWidget(text: '₹ '),
    );
  }
}
