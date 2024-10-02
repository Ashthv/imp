import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/choice_chip/chip_widget.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/amount_fund_transfer_textfield.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class AmountFundTransferTextfieldScreen extends StatefulWidget {
  const AmountFundTransferTextfieldScreen({super.key});

  @override
  State<AmountFundTransferTextfieldScreen> createState() =>
      _AmountFundTransferTextfieldScreenState();
}

class _AmountFundTransferTextfieldScreenState
    extends State<AmountFundTransferTextfieldScreen> {
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void setChiplabelToController(final String chiplabel) {
    setState(() {
      amountController.text = chiplabel;
    });
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
    return Column(
      children: [
        AmountFundTransferTextfield(
          controller: amountController,
          onChanged: (final text) {
            setState(() {});
          },
          infoText: 'Enter amount',
          maxLength: 8,
          prefixText: '₹',
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ChipWidget(
                label: '2,000',
                isSelected: amountController.text == '2,000',
                onSelected: (final label) {
                 // setChiplabelToController(label);
                },
              ),
              SizedBox(width: size.size10.dp),
              ChipWidget(
                label: '5,000',
                isSelected: amountController.text == '5,000',
                onSelected: (final label) {
                //  setChiplabelToController(label);
                },
              ),
              SizedBox(width: size.size10.dp),
              ChipWidget(
                label: '8,000',
                isSelected: amountController.text == '8,000',
                onSelected: (final label) {
                //  setChiplabelToController(label);
                },
              ),
              SizedBox(width: size.size10.dp),
              ChipWidget(
                label: '10,000',
                isSelected: amountController.text == '10,000',
                onSelected: (final label) {
                //  setChiplabelToController(label);
                },
              ),
              SizedBox(width: size.size10.dp),
              ChipWidget(
                label: '12,000',
                isSelected: amountController.text == '12,000',
                onSelected: (final label) {
                 // setChiplabelToController(label);
                },
              ),
              SizedBox(width: size.size10.dp),
              ChipWidget(
                label: '15,000',
                isSelected: amountController.text == '15,000',
                onSelected: (final label) {
                //  setChiplabelToController(label);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
