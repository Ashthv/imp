import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

class AadharcardTextScreen extends StatefulWidget {
  const AadharcardTextScreen({super.key});

  @override
  State<AadharcardTextScreen> createState() => _AadharcardTextScreenState();
}

class _AadharcardTextScreenState extends State<AadharcardTextScreen> {
  CustomTextEditingController? textEditingController1;
  CustomTextEditingController? textEditingController2;
  CustomTextEditingController? textEditingController3;
  String buttonLabel = 'Verify';
  bool aadhaarButtonEnabled = false;
  bool panButtonEnabled = false;
  bool verified = false;
  @override
  void initState() {
    textEditingController1 = CustomTextEditingController(
      isAadhar: true, //true for aadhar and false for pancard
      maskingLength: 13, //9 for aadhar and 13 for vid including space
      // and 5 for pancard
    );
    textEditingController2 = CustomTextEditingController(
      isAadhar: true, //true for aadhar and false for pancard
      maskingLength: 9, //9 for aadhar and 13 for vid including space
      // and 5 for pancard
    );
    textEditingController3 = CustomTextEditingController(
      isAadhar: false, //true for aadhar and false for pancard
      maskingLength: 5, //9 for aadhar and 13 for vid including space
      // and 5 for pancard
    );

    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      textEditingController1?.dispose();
      textEditingController2?.dispose();
      textEditingController3?.dispose();
    }
    super.dispose();
  }

  bool maskText = true;
  void onPress() {
    setState(() {
      buttonLabel = 'Save and Next';
      verified = true;
    });
  }

  void onPressQr() {
    setState(() {
      textEditingController1?.clear();
      textEditingController2?.clear();
      textEditingController3?.clear();
    });
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final locale = context.locale;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: size.size15.dp,
          right: size.size15.dp,
        ),
        child: Column(
          children: [
            AadhaarPanTextField(
              textEditingController: textEditingController2!,
              label: 'Aadhaar number(12 digits)',
              verified: verified,
              inputType: TextInputType.text,
              fieldType: FieldType.aadhaarNo,
              textFieldtypeText: 'Optional',
              validators: [
                RequiredValidator(
                  errorText: 'Aadhaar No Required',
                ),
                AadhaarValidator(errorText: 'Invalid aadhaar'),
              ],
              isValid: (final isValid) {
                setState(() {
                  aadhaarButtonEnabled = isValid;
                });
              },
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            Row(
              children: [
                Expanded(
                  child: NormalButton(
                    caption: buttonLabel,
                    buttonType: ButtonVariants.normal,
                    isEnabled: aadhaarButtonEnabled,
                    onPressed: onPress,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            AadhaarPanTextField(
              textEditingController: textEditingController3!,
              label: 'Pan number(10 Character)',
              verified: verified,
              inputType: TextInputType.text,
              fieldType: FieldType.panNo,
              textFieldtypeText: 'Optional',
              validators: [
                RequiredValidator(
                  errorText: '${locale.txt(key: 'panNumber')} Required',
                ),
                PanValidator(
                  errorText: 'Invalid Pan',
                ),
              ],
              isValid: (final isValid) {
                setState(() {
                  panButtonEnabled = isValid;
                });
              },
            ),
            SizedBox(
              height: size.size20.dp,
            ),
            Row(
              children: [
                Expanded(
                  child: NormalButton(
                    caption: buttonLabel,
                    buttonType: ButtonVariants.normal,
                    isEnabled: panButtonEnabled,
                    onPressed: onPress,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
