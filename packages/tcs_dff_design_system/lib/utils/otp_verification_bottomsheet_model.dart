import 'dart:ui';

class OtpVerificationBottomsheetModel {
  final String title;
  final String subTitle;
  final List<String>? subTitleHighlightedText;
  final int mPinLength;
  final bool isPinInvalid;
  final String errorMessage;
  final String? resendOtpText;
  final Duration? resendOtpDuration;
  final int? resendOtpMaxAttempts;
  final String submitButtonTitle;
  final String? footerNoteText;
  final VoidCallback? onCloseButtonTap;
  final VoidCallback? onFooterNoteTap;
  final VoidCallback onSubmitTap;
  final VoidCallback? onResendOtpTap;
  final bool isMPin;
  final Function(String pin) enteredPin;

  const OtpVerificationBottomsheetModel({
    required this.title,
    required this.subTitle,
    this.subTitleHighlightedText,
    required this.mPinLength,
    required this.isPinInvalid,
    required this.enteredPin,
    required this.errorMessage,
    required this.submitButtonTitle,
    this.resendOtpText,
    this.resendOtpDuration,
    this.resendOtpMaxAttempts,
    this.footerNoteText,
    this.onCloseButtonTap,
    this.onFooterNoteTap,
    this.onResendOtpTap,
    this.isMPin=false,
    required this.onSubmitTap,
  });
}
