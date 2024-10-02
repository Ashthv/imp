import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/choose_language_card/choose_language_card.dart';
import 'package:tcs_dff_design_system/uikit/container/choose_language_card/language_select_model.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class ChooseLanguageScreen extends StatefulWidget {
  ChooseLanguageScreen({super.key});
  
  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  late final ChooseLanguageModel dummyData;
  //final locale = context.locale;
  @override
  void initState() {
    super.initState();
     dummyData = ChooseLanguageModel(
      language: 'English',//locale.txt(key: 'languageEng'),
      localeText: 'Hello',//locale.txt(key: 'textHeader'),
      isSelected: true,
    );
  }
  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
  dummyData..language = locale.txt(key: 'languageEng')
  ..localeText = locale.txt(key: 'textHeader');
  
  return Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(left: 60, right: 60),
                  child: ChooseLanguageCard(
                    onChanged: (final bool value) {
            setState(() {
              dummyData.isSelected = dummyData.isSelected ? false : true;
            });
          },
          isSelected: dummyData.isSelected,
          language: dummyData.language,
          localeText: dummyData.localeText,
                  ),
                ),
              );
  }
}
