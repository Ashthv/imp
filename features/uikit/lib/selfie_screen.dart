import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/foundation/selfie_widget.dart';

class SelfieScreen extends StatefulWidget {
  const SelfieScreen({super.key});

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Center(
        child: SelfieWidget(
          onFileCapturedCallBack: (final path) {},
        ),
      );
}
