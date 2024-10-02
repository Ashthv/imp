import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/mpin.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class MPinScreen extends StatefulWidget {
  const MPinScreen({super.key});

  @override
  State<MPinScreen> createState() => _MPinScreenState();
}

class _MPinScreenState extends State<MPinScreen> {
  String testingPin = '123456';
  String _pinEntered = '';
  bool _isValidPin = true;
  final List<TextEditingController> _pinInput1Controller = [];
  final List<TextEditingController> _pinInput2Controller = [];
  final List<TextEditingController> _pinInput3Controller = [];
  final List<TextEditingController> _pinInput4Controller = [];

  bool pinValidator(final String pinEntered) => pinEntered == testingPin;

  @override
  void dispose() {
    _pinInput1Controller.clear();
    _pinInput2Controller.clear();
    _pinInput3Controller.clear();
    _pinInput4Controller.clear();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.theme.appSize.size10.dp,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MPin(
                        isMpin: true,
                        isOutLineBorder: true,
                        mpinInputController: _pinInput1Controller,
                        mpinLength: 6,
                        isValidMpin: _isValidPin,
                        mpinCallBack: (final textPin) {
                          _pinEntered = textPin;
                        },
                        mpinStyle: MpinStyle(
                          borderColor: context.theme.appColor.clrPrimaryPurple,
                          fillColor: context.theme.appColor.greyFullWhite120,
                          textColor: context.theme.appColor.clrPrimaryPurple,
                          focusedBorderColor:
                              context.theme.appColor.clrPrimaryPurple,
                          textSize: context.theme.appSize.size16.dp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                MPin(
                  isOutLineBorder: true,
                  mpinInputController: _pinInput2Controller,
                  mpinLength: 6,
                  isValidMpin: _isValidPin,
                  mpinCallBack: (final textPin) {
                    _pinEntered = textPin;
                  },
                  mpinStyle: MpinStyle(
                    borderColor: context.theme.appColor.clrPrimaryPurple,
                    fillColor: context.theme.appColor.greyFullWhite120,
                    textColor: context.theme.appColor.clrPrimaryPurple,
                    focusedBorderColor: context.theme.appColor.clrPrimaryPurple,
                    textSize: context.theme.appSize.size35.dp,
                  ),
                ),
                SizedBox(
                  height: context.theme.appSize.size10.dp,
                ),
                Container(
                  color: context.theme.appColor.clrPrimaryBlue10,
                  child: Row(
                    children: [
                      Expanded(
                        child: MPin(
                          // isOutLineBorder: true,
                          mpinInputController: _pinInput3Controller,
                          mpinLength: 6,
                          isValidMpin: _isValidPin,
                          mpinCallBack: (final textPin) {
                            _pinEntered = textPin;
                          },
                          mpinStyle: MpinStyle(
                            borderColor:
                                context.theme.appColor.greyFullWhite120,
                            fillColor: context.theme.appColor.transparent,
                            textColor: context.theme.appColor.greyFullWhite120,
                            focusedBorderColor:
                                context.theme.appColor.greyFullWhite120,
                            textSize: context.theme.appSize.size35.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: context.theme.appColor.clrPrimaryBlue10,
                  child: MPin(
                    mpinInputController: _pinInput4Controller,
                    mpinLength: 6,
                    isValidMpin: _isValidPin,
                    mpinCallBack: (final textPin) {
                      _pinEntered = textPin;
                    },
                    mpinStyle: MpinStyle(
                      borderColor: context.theme.appColor.greyFullWhite120,
                      fillColor: context.theme.appColor.transparent,
                      textColor: context.theme.appColor.greyFullWhite120,
                      focusedBorderColor:
                          context.theme.appColor.greyFullWhite120,
                      textSize: context.theme.appSize.size35.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.theme.appSize.size30.dp,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      clearAllMpins();
                      _isValidPin = pinValidator(_pinEntered);
                    });
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      );

  void clearAllMpins() {
    for (final element in _pinInput1Controller) {
      element.text = '';
    }
    for (final element in _pinInput2Controller) {
      element.text = '';
    }
    for (final element in _pinInput3Controller) {
      element.text = '';
    }
    for (final element in _pinInput4Controller) {
      element.text = '';
    }
  }
}
