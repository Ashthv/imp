import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/foundation/button/normal_button.dart';
import 'package:tcs_dff_design_system/utils/button_utils.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_design_system/utils/snackbar_utils.dart';
import 'package:tcs_dff_device_feature/biometrics/biometrics.dart';

class DemoBiometrics extends StatefulWidget {
  const DemoBiometrics({super.key});

  @override
  State<DemoBiometrics> createState() => _DemoBiometricsState();
}

class _DemoBiometricsState extends State<DemoBiometrics> {
  final instance = Biometrics();

  late BuildContext _context;

  @override
  Widget build(final BuildContext context) {
    _context = context;
    return Padding(
      padding: EdgeInsets.all(32.dp),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24.dp),
            buildAuthenticate(),
          ],
        ),
      ),
    );
  }

  Widget buildAuthenticate() => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAuthComplete = await instance.authenticate(
            localizedReason: 'Scan Fingerprint to authenticate',
            options: const AuthOptions(
              biometricOnly: true,
              stickyAuth: true,
            ),
          );

          if (isAuthComplete.isAuthenticated) {
            successBiometric();
          }
        },
      );

  void successBiometric() {
    showSnackBar(
      context: _context,
      snackbarType: SnackbarType.success,
      message: 'User authenticated successfully',
    );
  }

  Widget buildButton({
    required final String text,
    required final IconData icon,
    required final VoidCallback onClicked,
  }) =>
      NormalButton(
        caption: text,
        buttonType: ButtonVariants.twoColumn,
        onPressed: onClicked,
      );
}
