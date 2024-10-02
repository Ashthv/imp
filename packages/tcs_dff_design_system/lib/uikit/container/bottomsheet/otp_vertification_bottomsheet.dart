import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../theme/theme_extensions/color_extension.dart';
import '../../../theme/theme_extensions/size_extension.dart';
import '../../../theme/theme_extensions/text_style_extension.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../footer_note_widget.dart';

class OtpVerificationBottomsheetTemplate extends StatefulWidget {
  const OtpVerificationBottomsheetTemplate({
    super.key,
    required this.otpVerificationBottomsheetModel,
  });
  final OtpVerificationBottomsheetModel otpVerificationBottomsheetModel;

  @override
  State<OtpVerificationBottomsheetTemplate> createState() =>
      _OtpVerificationBottomsheetTemplateState();
}

class _OtpVerificationBottomsheetTemplateState
    extends State<OtpVerificationBottomsheetTemplate> {
  final List<TextEditingController> _pinInputController = [];
  bool _isSubmitEnabled = false;
  bool _isMpinMaksed = true;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final locale = context.locale;
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleSubTitleContainer(size, color, textStyle),
          if (widget.otpVerificationBottomsheetModel.errorMessage != '')
            NoteWidget(
              heading: widget.otpVerificationBottomsheetModel.errorMessage,
              variant: NoteVariants.errorInfoNote,
              description: '',
            ),
          mPinContainer(size, color, context, locale),
          Visibility(
            visible:
                widget.otpVerificationBottomsheetModel.footerNoteText != null,
            child: FooterNoteWidget(
              title:
                  widget.otpVerificationBottomsheetModel.footerNoteText ?? '',
              package: 'tcs_dff_design_system',
              onpressed:
                  widget.otpVerificationBottomsheetModel.onFooterNoteTap ??
                      () {},
              trailingImage: 'assets/images/arrow_right_purple.svg',
            ),
          ),
        ],
      ),
    );
  }

  Container titleSubTitleContainer(
    final AppSizeExtension size,
    final AppColorsExtension color,
    final AppTextStyleExtension textStyle,
  ) =>
      Container(
        padding: EdgeInsets.only(
          top: size.size20.dp,
          left: size.size21.dp,
          right: size.size21.dp,
          bottom: size.size10.dp,
        ),
        color: color.clrPrimaryBlue,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextWidget(
                    text: widget.otpVerificationBottomsheetModel.title,
                    style: textStyle.h124pxsemiBold.copyWith(
                      fontSize: size.size24.sp,
                      fontWeight: FontWeight.w700,
                      color: color.greyFullWhite120,
                    ),
                  ),
                ),
                InkWell(
                  onTap:
                      widget.otpVerificationBottomsheetModel.onCloseButtonTap,
                  child: ImageWidget(
                    imageType: ImageType.assetImage,
                    path: 'assets/images/close.svg',
                    package: 'tcs_dff_design_system',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.size30.dp,
            ),
            TextWidget(
              text: widget.otpVerificationBottomsheetModel.subTitle,
              style: textStyle.bodyCopy2Small16Regular.copyWith(
                color: color.greyFullWhite120,
              ),
              styledTextList: widget
                  .otpVerificationBottomsheetModel.subTitleHighlightedText,
              styledTextStyle: textStyle.bodyCopy2Large16Bold.copyWith(
                color: color.greyFullWhite120,
                fontWeight: FontWeight.w700,
                fontSize: size.size16,
              ),
            ),
          ],
        ),
      );

  Container mPinContainer(
    final AppSizeExtension size,
    final AppColorsExtension color,
    final BuildContext context,
    final AppLocalizations locale,
  ) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.size15.dp,
          vertical: size.size15.dp,
        ),
        color: widget.otpVerificationBottomsheetModel.errorMessage == ''
            ? color.clrPrimaryBlue10
            : color.statRedDark,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: MPin(
                    isMpin: widget.otpVerificationBottomsheetModel.isMPin,
                    contentPadding: EdgeInsets.all(size.size2.dp),
                    obscureText: _isMpinMaksed,
                    mpinInputController: _pinInputController,
                    mpinLength:
                        widget.otpVerificationBottomsheetModel.mPinLength,
                    isValidMpin:
                        widget.otpVerificationBottomsheetModel.isPinInvalid,
                    mpinCallBack: (final textPin) {
                      setState(() {
                        widget.otpVerificationBottomsheetModel
                            .enteredPin(textPin);
                        if (textPin.length ==
                            widget.otpVerificationBottomsheetModel.mPinLength) {
                          _isSubmitEnabled = true;
                        } else {
                          _isSubmitEnabled = false;
                        }
                      });
                    },
                    mpinStyle: MpinStyle(
                      borderColor: context.theme.appColor.greyFullWhite120,
                      fillColor: context.theme.appColor.transparent,
                      textColor: context.theme.appColor.greyFullWhite120,
                      focusedBorderColor:
                          context.theme.appColor.greyFullWhite120,
                      textSize: context.theme.appSize.size35.sp,
                      cursorColor: context.theme.appColor.transparent,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.dp,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isMpinMaksed = !_isMpinMaksed;
                    });
                  },
                  child: Icon(
                    _isMpinMaksed
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: color.greyFullWhite120,
                    size: 24.dp,
                  ),
                ),
              ],
            ),
            Visibility(
              visible:
                  widget.otpVerificationBottomsheetModel.resendOtpDuration !=
                      null,
              child: Padding(
                padding: EdgeInsets.only(
                  top: size.size30.dp,
                ),
                child: ResendOtp(
                  text: widget.otpVerificationBottomsheetModel.resendOtpText ??
                      '',
                  duration: widget
                          .otpVerificationBottomsheetModel.resendOtpDuration ??
                      const Duration(),
                  maxAttempt: widget.otpVerificationBottomsheetModel
                          .resendOtpMaxAttempts ??
                      0,
                  callback:
                      widget.otpVerificationBottomsheetModel.onResendOtpTap ??
                          () {},
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: size.size42.dp),
              child: BorderlinedButton(
                caption:
                    widget.otpVerificationBottomsheetModel.submitButtonTitle,
                onPressed: () {
                  widget.otpVerificationBottomsheetModel.onSubmitTap();
                  if (widget.otpVerificationBottomsheetModel.isPinInvalid ==
                      false) {
                    clearPin(_pinInputController);
                  }
                },
                isEnabled: _isSubmitEnabled,
                buttonType: ButtonVariants.fourColumn,
              ),
            ),
          ],
        ),
      );
}

void clearPin(final List<TextEditingController> textEditingController) {
  for (var i = 0; i < textEditingController.length; i++) {
    textEditingController[i].clear();
  }
}
