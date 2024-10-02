import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/button_utils.dart';
import '../../../utils/footer_stepper_utils.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../container/checkbox/checkbox_title.dart';
import '../../container/footer_note_widget.dart';
import '../button/normal_button.dart';
import '../button/round_button.dart';
import '../text_widget.dart';
import 'footer_stepper_variant_model.dart';

class FooterStepper extends StatelessWidget {
  FooterStepper({
    super.key,
    required this.footerStepperVariants,
    required this.onButtonPressed,
    this.isDefaultButtonEnabled = true,
    this.footerStepperTitleSubtitleModel =
        const FooterStepperTitleSubtitleModel(),
    this.footerStepperBackButtonModel = const FooterStepperBackButtonModel(),
    this.footerStepperButtonCaptionModel =
        const FooterStepperButtonCaptionModel(),
    this.footerStepperCheckboxModel = const FooterStepperCheckboxModel(),
    this.footerStepperNoteWidgetModel = const FooterStepperNoteWidgetModel(),
  });

  final FooterStepperVariants footerStepperVariants;
  final Function() onButtonPressed;
  final bool isDefaultButtonEnabled;
  final FooterStepperTitleSubtitleModel footerStepperTitleSubtitleModel;
  final FooterStepperBackButtonModel footerStepperBackButtonModel;
  final FooterStepperButtonCaptionModel footerStepperButtonCaptionModel;
  final FooterStepperCheckboxModel footerStepperCheckboxModel;
  final FooterStepperNoteWidgetModel footerStepperNoteWidgetModel;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: footerStepperVariants ==
              FooterStepperVariants.footerWithNoteWidget,
          child: FooterNoteWidget(
            title: footerStepperNoteWidgetModel.title,
            package: footerStepperNoteWidgetModel.package,
            onpressed: footerStepperNoteWidgetModel.onPressed ?? () {},
            trailingImage: footerStepperNoteWidgetModel.trailingImage,
            leadingImage: footerStepperNoteWidgetModel.leadingImage,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.size21.dp,
            vertical: size.size10.dp,
          ),
          child: getFooterWidget(context),
        ),
      ],
    );
  }

  Widget getFooterWidget(final BuildContext context) {
    final style = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible:
                footerStepperVariants == FooterStepperVariants.footerWithBack,
            child: RoundButton(
              onPressed:
                  footerStepperBackButtonModel.onBackButtonPressed ?? () {},
              buttonVariant: ButtonVariants.circular,
              iconPath: 'assets/images/ic_arrow_backword.svg',
              package: 'tcs_dff_design_system',
              buttonType: RoundedButtonType.borderlined,
              isEnabled: footerStepperBackButtonModel.isBackButtonEnabled,
              buttonColor: color.clrPrimaryPurple,
            ),
          ),
          Visibility(
            visible: footerStepperVariants ==
                FooterStepperVariants.footerWithCheckbox,
            child: Expanded(
              child: CheckboxTitle(
                onChanged: footerStepperCheckboxModel.checkboxCheckValue,
                isChecked: footerStepperCheckboxModel.isCheckboxChecked,
                textWidget: TextWidget(
                  text: footerStepperCheckboxModel.checkboxCaption,
                  style: style.bodyCopy3Medium14SemiBold.copyWith(
                    fontStyle: FontStyle.normal,
                  ),
                ),
                disabled: footerStepperCheckboxModel.isCheckboxDisabled,
                isMixed: footerStepperCheckboxModel.isCheckboxMixed,
                onInfoPressed: footerStepperCheckboxModel.checkboxInfoPress,
              ),
            ),
          ),
          Visibility(
            visible: footerStepperVariants !=
                FooterStepperVariants.footerWithCheckbox,
            child: const Spacer(),
          ),
          Visibility(
            visible: footerStepperVariants !=
                FooterStepperVariants.footerWithCheckbox,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: footerStepperTitleSubtitleModel.stepperTitle,
                      style: style.bodyCopy3Small14Regular.copyWith(
                        color: color.greyLighterGrey70,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.end,
                      styledTextList:
                          footerStepperTitleSubtitleModel.titleStyledTextList,
                      styledTextStyle:
                          footerStepperTitleSubtitleModel.titleStyledTextStyle,
                    ),
                    TextWidget(
                      text: footerStepperTitleSubtitleModel.stepperSubitle,
                      style: style.bodyCopy3Small14Regular.copyWith(
                        color: color.greyDarkestGrey20,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.end,
                      styledTextList: footerStepperTitleSubtitleModel
                          .subTitleStyledTextList,
                      styledTextStyle: footerStepperTitleSubtitleModel
                          .subTitleStyledTextStyle,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.size16.dp),
                  child: VerticalDivider(
                    color: color.greyLighterGrey70,
                    width: size.size0.dp,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: footerStepperVariants !=
                FooterStepperVariants.footerWithButtonCaption,
            child: RoundButton(
              onPressed: onButtonPressed,
              buttonVariant: ButtonVariants.circular,
              iconPath: 'assets/images/ic_arrow_forward.svg',
              package: 'tcs_dff_design_system',
              isEnabled: isDefaultButtonEnabled,
              buttonColor: color.greyFullWhite120,
            ),
          ),
          Visibility(
            visible: footerStepperVariants ==
                FooterStepperVariants.footerWithButtonCaption,
            child: NormalButton(
              caption: footerStepperButtonCaptionModel.textButtonCaption,
              buttonType: ButtonVariants.twoColumn,
              onPressed: onButtonPressed,
              rightIcon:
                  footerStepperButtonCaptionModel.textButtonRightIconPath,
              package: footerStepperButtonCaptionModel.backButtonIconPackage,
              isEnabled: footerStepperButtonCaptionModel.isTextButtonEnabled,
              leftIcon: footerStepperButtonCaptionModel.textButtonLeftIconPath,
            ),
          ),
        ],
      ),
    );
  }
}
