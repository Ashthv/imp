import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/foundation/button/borderlined_button.dart';
import 'package:tcs_dff_design_system/utils/button_utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'primary borderlined button',
  type: BorderlinedButton,
)
Widget primaryNormalButtonUseCase(final BuildContext context) =>
    BorderlinedButton(
      caption: 'text',
      onPressed: () => {},
      buttonType: context.knobs.list(
        label: 'Button Variants',
        options: [
          ButtonVariants.normal,
          ButtonVariants.twoColumn,
          ButtonVariants.fourColumn,
          ButtonVariants.cardTwoColumn,
          ButtonVariants.cardFourColumn,
        ],
        description: 'select button variants',
      ),
    );

@widgetbook.UseCase(
  name: 'primary two column borderlined button',
  type: BorderlinedButton,
)
Widget primaryTwoColumnButtonUseCase(final BuildContext context) =>
    BorderlinedButton(
      caption: 'text',
      onPressed: () => {},
      buttonType: ButtonVariants.twoColumn,
    );
