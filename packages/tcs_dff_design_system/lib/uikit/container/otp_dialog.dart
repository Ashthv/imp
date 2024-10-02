// import 'package:flutter/material.dart';

// import '../../theme/theme.dart';
// import '../../utils/button_utils.dart';
// import '../../utils/otp_dialog_model.dart';
// import '../../utils/sizer/app_sizer.dart';
// import '../foundation/button/borderlined_button.dart';
// import '../foundation/button/normal_button.dart';
// import '../foundation/mpin.dart';
// import '../foundation/resend_otp.dart';
// import '../foundation/text_widget.dart';

// class OtpDialog extends StatefulWidget {
//   final OtpDialogData otpDialogData;
//   // ignore: library_private_types_in_public_api
//   static final GlobalKey<_OtpDialogState> globalKey = GlobalKey();

//   OtpDialog({required this.otpDialogData}) : super(key: globalKey);

//   @override
//   State<OtpDialog> createState() => _OtpDialogState();
// }

// class _OtpDialogState extends State<OtpDialog> {
//   bool normalButtonEnabled = false;
//   String enteredPin = '';
//   final List<TextEditingController> _pinInputController = [];

//   @override
//   Widget build(final BuildContext context) {
//     final textStyle = context.theme.appTextStyles;
//     final color = context.theme.appColor;
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//               top: context.theme.appSize.size15.dp,
//               left: context.theme.appSize.size15.dp,
//               right: context.theme.appSize.size15.dp,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.topRight,
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.close),
//                   ),
//                 ),
//                 Text(
//                   widget.otpDialogData.title,
//                   style:
//                      context.theme.appTextStyles.labelSmall14Medium.copyWith(
//                     color: context.theme.appColor.clrPrimaryPurple,
//                     fontSize: context.theme.appSize.size25.dp,
//                   ),
//                 ),
//                 SizedBox(
//                   height: context.theme.appSize.size20.dp,
//                 ),
//                 TextWidget(text: widget.otpDialogData.subTitle),
//                 SizedBox(
//                   height: context.theme.appSize.size20.dp,
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     MPin(
//                       mpinInputController: _pinInputController,
//                       mpinLength: widget.otpDialogData.pinLength,
//                       mpinCallBack: (final textPin) {
//                         enteredPin = textPin;
//                         setState(() {
//                           textPin.length == widget.otpDialogData.pinLength
//                               ? normalButtonEnabled = true
//                               : normalButtonEnabled = false;

//                           textPin.length != widget.otpDialogData.pinLength
//                               ? normalButtonEnabled = false
//                               : normalButtonEnabled = true;
//                         });
//                       },
//                       isValidMpin: widget.otpDialogData.isValidPin,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: context.theme.appSize.size12.dp,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       child: Text(
//                         widget.otpDialogData.errorText,
//                         style: textStyle.h414pxRegular
//                            .copyWith(color: color.statRedDark, fontSize: 14),
//                       ),
//                     ),
//                     ResendOtp(
//                       text: widget.otpDialogData.resendOtpText,
//                       duration: widget.otpDialogData.resendOtpDuration,
//                       callback: () {
//                         widget.otpDialogData.resendOtpcallback(enteredPin);
//                         clearPin(_pinInputController);
//                         setState(() {
//                           normalButtonEnabled = false;
//                         });
//                       },
//                       maxAttempt: 2,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: context.theme.appSize.size24.dp,
//           ),
//           Container(
//             color: context.theme.appColor.clrPrimaryBlue100,
//             padding: EdgeInsets.only(
//               top: context.theme.appSize.size15.dp,
//               bottom: context.theme.appSize.size15.dp,
//               left: context.theme.appSize.size15.dp,
//               right: context.theme.appSize.size15.dp,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Expanded(
//                       child: BorderlinedButton(
//                         caption: widget.otpDialogData.titleBorderButton,
//                         onPressed: widget.otpDialogData.borderButtonCallback,
//                         buttonType: ButtonVariants.normal,
//                       ),
//                     ),
//                     SizedBox(
//                       width: context.theme.appSize.size10.dp,
//                     ),
//                     Expanded(
//                       child: NormalButton(
//                         caption: widget.otpDialogData.titleNormalButton,
//                         onPressed: () {
//                        widget.otpDialogData.normalButtonCallback(enteredPin);
//                         },
//                         isEnabled: normalButtonEnabled,
//                         buttonType: ButtonVariants.normal,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void clearPin(final List<TextEditingController> textEditingController) {
//     for (var i = 0; i < textEditingController.length; i++) {
//       textEditingController[i].clear();
//     }
//   }

//   void updateError(final String errorMessage) {
//     setState(() {
//       clearPin(_pinInputController);
//       widget.otpDialogData.errorText = errorMessage;
//     });
//   }
// }
