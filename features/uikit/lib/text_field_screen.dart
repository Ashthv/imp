// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/button/normal_button.dart';
import 'package:tcs_dff_design_system/uikit/foundation/icon_widget.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/chat_input_field.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/textfield_suffix_suggestion.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/textfield_widget.dart';
import 'package:tcs_dff_design_system/utils/button_utils.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  String stringData = '';
  bool validatorValue = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController usernameController2 = TextEditingController();
  TextEditingController panNoController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController confirmEmployeeIdController = TextEditingController();
  TextEditingController adharcardController = TextEditingController();
  TextEditingController mpinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController suffixController = TextEditingController();
  String _employeeId = '';
  bool maskText = true;

  final _formKey = GlobalKey<FormState>();
  final _employeeIdKey = GlobalKey<FormFieldState>();

//on change function works whenever the user type anything on the textfiels
  void onChangeValue(final String val, final bool isValid) {}
  void setMaskText() {
    setState(() {
      maskText = !maskText;
    });
  }

  @override
  void dispose() {
    if (!mounted) {
      usernameController.dispose();
      usernameController2.dispose();
      panNoController.dispose();
      employeeIdController.dispose();
      confirmEmployeeIdController.dispose();
      adharcardController.dispose();
      mpinController.dispose();
      passwordController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFieldWidget(
              controller: usernameController,
              label: locale.txt(key: 'username'),
              textFieldtypeText: 'Optional',
              helperWidget: Text(
                'Helper Text',
                style: textStyle.labelSmall14Medium.copyWith(
                  fontSize: size.size14.sp,
                  fontWeight: FontWeight.w400,
                  color: color.clrPrimaryBlue,
                ),
              ),
            ),
            TextFieldWidget(
              controller: usernameController2,
              label: locale.txt(key: 'employeeId'),
              focused: true,
              //enabled: false,
              ecoFriendlyWidget: Text(
                'Save paper! Receive bank statements digitally',
                style: textStyle.labelSmall14Medium.copyWith(
                  fontSize: size.size14.sp,
                  fontWeight: FontWeight.w400,
                  color: color.greenDark,
                ),
              ),
            ),
            TextFieldWidget(
              suffixWidget: IconWidget(
                package: 'uikit',
                iconName: maskText
                    ? 'images/visibility.png'
                    : 'images/visibility_off.png',
                iconSize: IconSize.small,
                onPressed: setMaskText,
              ),
              controller: panNoController,
              label: locale.txt(key: 'panNumber'),
              // ignore: avoid_redundant_argument_values
              inputType: TextInputType.text,
              validators: [
                RangeValidator(min: 8, max: 20, errorText: 'errrrrrrr'),
              ],
              helperWidget: Text(
                'Helper Text',
                style: textStyle.labelSmall14Medium.copyWith(
                  fontSize: size.size14.sp,
                  fontWeight: FontWeight.w400,
                  color: color.clrPrimaryBlue,
                ),
              ),
              ecoFriendlyWidget: Text(
                'Save paper! Receive bank statements digitally',
                style: textStyle.labelSmall14Medium.copyWith(
                  fontSize: size.size14.sp,
                  fontWeight: FontWeight.w400,
                  color: color.greenDark,
                ),
              ),
            ),
            TextFieldWidget(
              fieldKey: _employeeIdKey,
              suffixWidget: IconWidget(
                iconName: 'images/error.png',
                package: 'uikit',
                iconSize: IconSize.small,
                iconColor: color.statRedDefault,
              ),
              controller: employeeIdController,
              label: locale.txt(key: 'employeeId'),
              focused: true,
              inputType: TextInputType.number,
              onChanged: (final value) => setState(() => _employeeId = value),
              validators: [
                RequiredValidator(
                  errorText: '${locale.txt(key: 'employeeId')} Required',
                ),
                MatchLengthValidator(
                  7,
                  errorText: 'Invalid ${locale.txt(key: 'employeeId')}',
                ),
              ],
            ),
            TextFieldWidget(
              suffixWidget: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //constraints: BoxConstraints.tightFor(),
                      child: const Text('hello1'),
                    ),
                  ],
                ),
              ),
              controller: confirmEmployeeIdController,
              label: locale.txt(key: 'confirmEmployeeId'),
              inputType: TextInputType.number,
              validators: [
                RequiredValidator(
                  errorText: '${locale.txt(key: 'confirmEmployeeId')} Required',
                ),
                MatchValueValidator(
                  _employeeId,
                  errorText:
                      '${locale.txt(key: 'confirmEmployeeId')} does not match with ${locale.txt(key: 'employeeId')}',
                ),
              ],
            ),
            TextFieldWidget(
              controller: mpinController,
              label: locale.txt(key: 'mPin'),
              // infoText: 'Now transfer a maximum of ₹50,000 via quick transfer',
              inputType: TextInputType.number,
              validators: [
                LengthRangeValidator(min: 8, max: 20, errorText: 'eeerrr'),
              ],
            ),
            TextFieldWidget(
              controller: passwordController,
              maxLength: 10,
              label: 'TextFieldWidget',
              inputType: TextInputType.number,
              maskText: true,
              inputFormatters: [
                // FilteringTextInputFormatter.allow(RegExp('[0-9X]')),
                // FilteringTextInputFormatter.allow(
                //   RegExp('[A-Za-z0-9]'),
                // ),
              ],
              // infoText: 'Now transfer a maximum of ₹50,000 via quick transfer',
            ),
            TextfieldSuffixSuggestion(
              label: 'Label',
              controller: suffixController,
              suggestions: [
                '@tcs.com',
                '@tatagroup.com',
                '@tataconsultancyservices.co.in',
              ],
              validators: [
                RequiredValidator(
                  errorText: 'MANDATORY',
                ),
              ],
            ),
            ChatInputField(
              hintText: 'Type a message...',
              onPress: () {},
            ),
            SizedBox(height: size.size15.dp),
            NormalButton(
              caption: 'Verify',
              buttonType: ButtonVariants.normal,
              onPressed: () {
                // if (_employeeIdKey.currentState!.validate()) {
                // }

                if (_formKey.currentState!.validate()) {
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
