import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';

class CommonScaffoldScreen extends StatefulWidget {
  const CommonScaffoldScreen({super.key});

  @override
  State<CommonScaffoldScreen> createState() => _CommonScaffoldScreenState();
}

class _CommonScaffoldScreenState extends State<CommonScaffoldScreen> {
  @override
  Widget build(final BuildContext context) => BaseScaffoldWidget(
        body: Container(
          child: const Padding(
            padding: EdgeInsets.all(30),
            // ignore: lines_longer_than_80_chars
            child: Column(
              children: [
                Center(
                  child: TextWidget(
                    text:
                        // ignore: lines_longer_than_80_chars
                        ' "CommonScaffoldWidget" is a Widget which is similar as scaffold widget . here we already set the "SafeArea" Widget in  "CommonScaffold Widget" .  so no need to use the SafeArea every time when implementing userstory .  in future this widget willl be helpful for controlling UI in case of "network connectivity" , "data loading" , "data error"  and many more ',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
