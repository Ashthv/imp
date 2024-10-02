import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/radio_button/sim_slot/sim_slot.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class SimCardRadioButtonScreen extends StatefulWidget {
  const SimCardRadioButtonScreen({super.key});

  @override
  State<SimCardRadioButtonScreen> createState() =>
      _SimCardRadioButtonScreenState();
}

class _SimCardRadioButtonScreenState extends State<SimCardRadioButtonScreen> {
  bool sim1 = false, sim2 = false;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final locale = context.locale;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.size200.dp,
              width: size.size155.dp,
              child: SimSlot(
                imagePath: 'images/airtel_image.svg',
                package: 'uikit',
                title: locale.txt(key: 'airtel'),
                onChanged: (final bool value) {
                  setState(() {
                    if (!sim1) {
                      sim1 = true;
                      sim2 = false;
                    }
                  });
                },
                isSelected: sim1,
                isEnabled: true,
                isError: false,
              ),
            ),
            SizedBox(
              width: size.size20.dp,
            ),
            Container(
              height: size.size200.dp,
              width: size.size155.dp,
              child: SimSlot(
                imagePath: 'images/jio_image.svg',
                package: 'uikit',
                title: locale.txt(key: 'jio'),
                onChanged: (final bool value) {
                  setState(() {
                    if (!sim2) {
                      sim2 = true;
                      sim1 = false;
                    }
                  });
                },
                isSelected: sim2,
                isEnabled: true,
                isError: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
