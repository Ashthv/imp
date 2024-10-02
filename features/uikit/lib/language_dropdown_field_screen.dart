import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/dropdown/language_dropdown_field.dart';
import 'package:tcs_dff_design_system/utils/dropdown_menue_model.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class LanguageDropdownFieldScreen extends StatelessWidget {
  const LanguageDropdownFieldScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;

    return Column(
      children: [
        LanguageDropdownField(
          title: 'Select',
          dropdownMenuList: [
            DropdownMenuModel(
              title: 'Mr',
            ),
            DropdownMenuModel(
              title: 'Mrs',
            ),
            DropdownMenuModel(
              title: 'Dr',
            ),
          ],
          onOptionSelect: (final p0) {},
        ),
        SizedBox(
          height: size.size100.dp,
        ),
        LanguageDropdownField(
          title: 'select a languages',
          dropdownMenuList: [
            DropdownMenuModel(
              title: 'English',
            ),
            DropdownMenuModel(
              title: 'Hindi',
            ),
            DropdownMenuModel(
              title: 'Marathi',
            ),
            DropdownMenuModel(
              title: 'Tamil',
            ),
            DropdownMenuModel(
              title: 'Gujarati',
            ),
            DropdownMenuModel(
              title: 'Oriya',
            ),
            DropdownMenuModel(
              title: 'Telagu',
            ),
            DropdownMenuModel(
              title: 'Bengali',
            ),
            DropdownMenuModel(
              title: 'Malayalam',
            ),
          ],
          onOptionSelect: (final p0) {},
        ),
      ],
    );
  }
}
