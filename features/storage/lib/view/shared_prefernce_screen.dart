import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/utils/snackbar_utils.dart';
import 'package:tcs_dff_types/platform.dart';

class SharedPrefernceScreen extends StatefulWidget {
  const SharedPrefernceScreen({
    super.key,
  });

  @override
  State<SharedPrefernceScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<SharedPrefernceScreen> {
  final stringController = TextEditingController();
  final doubleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void setData() {
    dff.sharedPreferences
        .setStringValue(key: 'string', value: stringController.text);
    dff.sharedPreferences.setDoubleValue(
      key: 'double',
      value: double.parse(doubleController.text),
    );
  }

  void getData() {
    final stringvalue = dff.sharedPreferences.getStringValue(key: 'string');
    final doubleValue1 = dff.sharedPreferences.getDoubleValue(key: 'double');

    showSnackBar(
      context: context,
      snackbarType: SnackbarType.warning,
      message:
          ' String value is -$stringvalue and double value is -$doubleValue1',
    );
  }

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTextInput('Enter String', stringController),
                buildTextInput('Enter Double', doubleController),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: setData,
                        child: const Text(
                          'Save Data',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: getData,
                        child: const Text(
                          'SHOW Data',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

//Method to clear controller
  void clearController() {
    stringController.clear();
    doubleController.clear();
  }

  //Method to validate the user input
  bool validateData() {
    if (stringController.text.isNotEmpty && doubleController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Method to build text input controller
  Widget buildTextInput(
    final String hint,
    final TextEditingController textEditingController, {
    final bool isEnable = true,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            TextField(
              enabled: isEnable,
              controller: textEditingController,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                hintText: hint,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      );
}
