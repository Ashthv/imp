import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';
import 'mpin.dart';
import 'text_widget.dart';

class AccountNoMpinWidget extends StatefulWidget {
  final int mpinLength;
  final String accountNumber;
  final Function(String)? getAccountPin;

  const AccountNoMpinWidget({
    super.key,
    required this.mpinLength,
    this.getAccountPin,
    required this.accountNumber,
  });

  @override
  State<AccountNoMpinWidget> createState() => _AccountNoMpinWidgetState();
}

class _AccountNoMpinWidgetState extends State<AccountNoMpinWidget> {
  final List<TextEditingController> _pinInputController = [];
  String getPinEntered(final List<TextEditingController> pinInputController) {
    final otp = StringBuffer();
    for (var i = 0; i < pinInputController.length; i++) {
      otp.write(pinInputController[i].text);
    }
    return otp.toString();
  }

  @override
  Widget build(final BuildContext context) {
    final style = Theme.of(context).appTextStyles;
    final color = Theme.of(context).appColor;
    final size = Theme.of(context).appSize;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: size.size7.dp, right: size.size5.dp),
          child: TextWidget(
            text: widget.accountNumber,
            style: style.h414pxRegular.copyWith(
              fontSize: size.size14.dp,
              color: color.greyBlackUi10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: MPin(
            contentPadding: EdgeInsets.all(size.size3.dp),
            mpinLength: widget.mpinLength,
            obscureText: false,
            mpinInputController: _pinInputController,
            mpinCallBack: (final textPin) {
              setState(() {
                widget.getAccountPin!(getPinEntered(_pinInputController));
              });
            },
            mpinStyle: MpinStyle(
              borderColor: context.theme.appColor.greyLightestGrey80,
              textColor: context.theme.appColor.greyBlackUi10,
              focusedBorderColor: context.theme.appColor.clrPrimaryPurple,
              textSize: context.theme.appSize.size14.dp,
              cursorColor: context.theme.appColor.greyBlackUi10,
            ),
          ),
        ),
      ],
    );
  }
}
