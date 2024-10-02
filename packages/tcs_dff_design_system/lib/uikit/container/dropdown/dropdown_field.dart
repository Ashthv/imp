import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/dropdown_menue_model.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../bottomsheet/dropdown_bottomsheet.dart';

class DropdownField extends StatefulWidget {
  final List<DropdownMenuModel> dropdownMenuList;
  final String title;
  final bool isSearchEnabled;
  final String? currentLocation;
  final Function(DropdownMenuModel) onOptionSelect;
  final String? searchFieldHint;
  final String? allOptionTitle;
  final String? locationFieldTitle;
  final int? selectedIndex;
  final double lableHeight;
  final TextEditingController? dropdownFieldController;
  final Widget? bottomContent;
  final String? bottomSheetTitle;

  DropdownField({
    required this.dropdownMenuList,
    required this.title,
    this.isSearchEnabled = false,
    this.currentLocation,
    required this.onOptionSelect,
    this.searchFieldHint,
    this.allOptionTitle,
    this.locationFieldTitle,
    this.selectedIndex,
    this.lableHeight = 1.5,
    this.dropdownFieldController,
    this.bottomContent,
    this.bottomSheetTitle,
  });

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  late final TextEditingController dropdownFieldController;
  final FocusNode dropdownFieldFocus = FocusNode();

  @override
  void initState() {
    if (widget.dropdownFieldController != null) {
      dropdownFieldController = widget.dropdownFieldController!;
    } else {
      dropdownFieldController = TextEditingController();
    }
    if (widget.selectedIndex != null) {
      widget.dropdownFieldController?.text =
          widget.dropdownMenuList[widget.selectedIndex!].title;
    }
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    final bottomsheetTemplateData = BottomsheetTemplateData(
      backgroundColor: color.clrPrimaryBlue20,
      content: Flexible(
        child: DropdownBottomsheet(
          title: widget.bottomSheetTitle ?? widget.title,
          searchEnabled: widget.isSearchEnabled,
          showCurrentLocation: widget.currentLocation,
          searchFieldHintText: widget.searchFieldHint,
          allOptionTitle: widget.allOptionTitle,
          locationTitle: widget.locationFieldTitle,
          bottomContent: widget.bottomContent,
          onItemSelect: (final DropdownMenuModel selectedOption) {
            dropdownFieldController.text = selectedOption.title;

            setState(() {});
            widget.onOptionSelect(selectedOption);
          },
          items: widget.dropdownMenuList,
        ),
      ),
    );

    return Column(
      children: [
        InkWell(
          child: AbsorbPointer(
            child: TextFieldWidget(
              label: widget.title,
              labelHeight: widget.lableHeight,
              controller: dropdownFieldController,
              focusNode: dropdownFieldFocus,
              suffixWidget: dropdownFieldFocus.hasFocus
                  ? null
                  : Icon(
                      Icons.keyboard_arrow_down,
                      color: color.clrPrimaryPurple,
                      size: size.size24.dp,
                    ),
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
      ],
    );
  }
}
