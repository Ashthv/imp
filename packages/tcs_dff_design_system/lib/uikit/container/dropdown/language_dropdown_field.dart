import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/dropdown_menue_model.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../bottomsheet/dropdown_bottomsheet.dart';

class LanguageDropdownField extends StatefulWidget {
  final List<DropdownMenuModel> dropdownMenuList;
  final String title;
  final Function(DropdownMenuModel) onOptionSelect;

  LanguageDropdownField({
    required this.dropdownMenuList,
    required this.title,
    required this.onOptionSelect,
  });

  @override
  State<LanguageDropdownField> createState() => _LanguageDropdownFieldState();
}

class _LanguageDropdownFieldState extends State<LanguageDropdownField> {
  String? inputText;

  @override
  void initState() {
    inputText = widget.dropdownMenuList.first.title;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;

    final bottomsheetTemplateData = BottomsheetTemplateData(
      backgroundColor: color.clrPrimaryBlue20,
      content: Flexible(
        child: DropdownBottomsheet(
          title: widget.title,
          onItemSelect: (final DropdownMenuModel selectedOption) {
            inputText = selectedOption.title;
            setState(() {});
            widget.onOptionSelect(selectedOption);
          },
          items: widget.dropdownMenuList,
        ),
      ),
    );

    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: color.greyLightestGrey80,
            ),
          ),
        ),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.only(
              top: size.size10.dp,
              right: size.size7.dp,
              bottom: size.size10.dp,
              left: size.size10.dp,
            ),
            child: Row(
              children: [
                Text(
                  inputText!,
                  style: textStyle.bodyCopy1Small18Regular.copyWith(
                    fontSize: size.size18.sp,
                    fontWeight: FontWeight.w400,
                    color: color.greyMediumGrey40,
                  ),
                ),
                SizedBox(
                  width: size.size3.dp,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: color.clrPrimaryPurple,
                  size: size.size30.dp,
                ),
              ],
            ),
          ),
          onTap: () {
            showBottomSheetModal(
              context,
              BottomsheetTemplate(
                bottomsheetTemplateData: bottomsheetTemplateData,
              ),
            );
          },
        ),
      ),
    );
  }
}
