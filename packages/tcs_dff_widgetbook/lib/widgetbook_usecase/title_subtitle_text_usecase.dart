import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'description text',
  type: TitleSubtitleTextWidget,
)
Widget titleSubtitleTextUseCase(final BuildContext context) =>
    TitleSubtitleTextWidget(
      title: context.knobs.string(label: 'Title label', initialValue: 'Title'),
      subtitle: context.knobs
          .string(label: 'Subtitle lable', initialValue: 'Subtitle'),
    );
