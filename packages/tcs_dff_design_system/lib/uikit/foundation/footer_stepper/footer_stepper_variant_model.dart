import 'package:flutter/material.dart';

class FooterStepperTitleSubtitleModel {
  final String stepperTitle;
  final String stepperSubitle;
  final List<String>? titleStyledTextList;
  final TextStyle? titleStyledTextStyle;
  final List<String>? subTitleStyledTextList;
  final TextStyle? subTitleStyledTextStyle;

  const FooterStepperTitleSubtitleModel({
    this.stepperTitle = '',
    this.stepperSubitle = '',
    this.titleStyledTextList,
    this.titleStyledTextStyle,
    this.subTitleStyledTextList,
    this.subTitleStyledTextStyle,
  });
}

class FooterStepperBackButtonModel {
  final Function()? onBackButtonPressed;
  final bool isBackButtonEnabled;

  const FooterStepperBackButtonModel({
    this.onBackButtonPressed,
    this.isBackButtonEnabled = true,
  });
}

class FooterStepperButtonCaptionModel {
  final String textButtonCaption;
  final String? textButtonRightIconPath;
  final String? textButtonLeftIconPath;
  final bool isTextButtonEnabled;
  final String? backButtonIconPackage;

  const FooterStepperButtonCaptionModel({
    this.textButtonCaption = '',
    this.textButtonRightIconPath,
    this.textButtonLeftIconPath,
    this.isTextButtonEnabled = true,
    this.backButtonIconPackage,
  });
}

class FooterStepperCheckboxModel {
  final String checkboxCaption;
  final bool isCheckboxChecked;
  final ValueChanged<bool>? checkboxCheckValue;
  final bool isCheckboxDisabled;
  final bool isCheckboxMixed;
  final Function()? checkboxInfoPress;

  const FooterStepperCheckboxModel({
    this.checkboxCaption = '',
    this.isCheckboxChecked = false,
    this.checkboxCheckValue,
    this.isCheckboxDisabled = false,
    this.isCheckboxMixed = false,
    this.checkboxInfoPress,
  });
}

class FooterStepperNoteWidgetModel {
  final String title;
  final String? trailingImage;
  final String? leadingImage;
  final String? package;
  final Function()? onPressed;

  const FooterStepperNoteWidgetModel({
    this.title = '',
    this.trailingImage,
    this.leadingImage,
    this.package,
    this.onPressed,
  });
}
