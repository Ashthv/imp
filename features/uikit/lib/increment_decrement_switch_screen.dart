import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';

class IncrementDecrementSwitchScreen extends StatelessWidget {
  const IncrementDecrementSwitchScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: IncrementDecrementSwitch(
          onCounterValueChanged: (final currentValue) {},
          maxLimit: 10,
        ),
      );
}
