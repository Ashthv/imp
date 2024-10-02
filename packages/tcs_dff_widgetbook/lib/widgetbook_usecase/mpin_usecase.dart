import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'mpin pinLength 5',
  type: MPin,
)
Widget mpinPinLengthFiveUseCase(final BuildContext context) =>
    MPin(mpinLength: 5, mpinCallBack: (final textPin) {});

@widgetbook.UseCase(
  name: 'mpin pinLength 6',
  type: MPin,
)
Widget mpinPinLengthSixUseCase(final BuildContext context) =>
    MPin(mpinLength: 6, mpinCallBack: (final textPin) {});


