import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/dropdown_menue_model.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'dropdown_bottomsheet_list_tile.dart';

class DropdownBottomsheet extends StatefulWidget {
  final String title;
  final List<DropdownMenuModel> items;
  final bool searchEnabled;
  final String? showCurrentLocation;
  final Function(DropdownMenuModel) onItemSelect;
  final String? searchFieldHintText;
  final String? allOptionTitle;
  final String? locationTitle;
  final Widget? bottomContent;

  DropdownBottomsheet({
    required this.title,
    required this.items,
    required this.onItemSelect,
    this.searchEnabled = false,
    this.showCurrentLocation,
    this.searchFieldHintText,
    this.allOptionTitle,
    this.locationTitle,
    this.bottomContent,
  });

  @override
  State<DropdownBottomsheet> createState() => _DropdownBottomsheetState();
}

class _DropdownBottomsheetState extends State<DropdownBottomsheet> {
  TextEditingController dropdownFieldController = TextEditingController();

  List<DropdownMenuModel> _list = [];
  final FocusNode searchFieldFocus = FocusNode();

  @override
  void initState() {
    _list = widget.items;
    searchFieldFocus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    dropdownFieldController.dispose();
    super.dispose();
  }

  void searchDropdownList(final String searchText) {
    var _searchDropdownList = widget.items;
    if (searchText.isNotEmpty) {
      _searchDropdownList = widget.items
          .where(
            (final element) => element.title.toLowerCase().contains(
                  searchText.toLowerCase(),
                ),
          )
          .toList();
    }

    setState(() {
      _list = _searchDropdownList;
    });
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;

    return Container(
      color: color.clrPrimaryBlue10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: color.clrPrimaryBlue20,
            padding: EdgeInsets.only(
              right: size.size21.dp,
              left: size.size21.dp,
              top: size.size60.dp,
              bottom: size.size20.dp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.title,
                    style: textStyle.h124pxsemiBold.copyWith(
                      fontSize: size.size24.sp,
                      fontWeight: FontWeight.w700,
                      color: color.greyWhiteUi100,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: color.greyWhiteUi100,
                    size: size.size24.dp,
                  ),
                  onTap: () {
                    RouteNavigator.popDialog(context);
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.searchEnabled)
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: size.size24.dp,
                      horizontal: size.size21.dp,
                    ),
                    color: color.clrPrimaryBlue10,
                    child: Container(
                      color: color.clrPrimaryBlue20,
                      child: TextFieldWidget(
                        focusNode: searchFieldFocus,
                        controller: dropdownFieldController,
                        label: '',
                        hintText: widget.searchFieldHintText,
                        onChanged: searchDropdownList,
                        suffixWidget: InkWell(
                          onTap: () {
                            dropdownFieldController.clear();
                            setState(() {
                              _list = widget.items;
                            });
                            if (searchFieldFocus.hasFocus) {
                              searchFieldFocus.unfocus();
                            } else {
                              searchFieldFocus.requestFocus();
                            }
                          },
                          child: Icon(
                            searchFieldFocus.hasFocus
                                ? Icons.close
                                : Icons.search,
                            color: color.greyWhiteUi100,
                            size: size.size24.dp,
                          ),
                        ),
                        textColor: color.greyWhiteUi100,
                      ),
                    ),
                  ),
                if (widget.showCurrentLocation != null)
                  Visibility(
                    visible: widget.showCurrentLocation != null,
                    child: Container(
                      padding: EdgeInsets.only(top: size.size24.dp),
                      color: color.clrPrimaryBlue10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Icon(
                                  Icons.my_location,
                                  color: color.clrPrimaryBlue80,
                                ),
                                SizedBox(
                                  width: size.size8.dp,
                                ),
                                if (widget.locationTitle != null)
                                  Text(
                                    widget.locationTitle!,
                                    style: textStyle.h414pxRegular.copyWith(
                                      color: color.clrPrimaryBlue80,
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.size14.sp,
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: size.size12.dp,
                              ),
                              child: Text(
                                '${widget.showCurrentLocation}',
                                style:
                                    textStyle.bodyCopy1Small18Regular.copyWith(
                                  color: color.greyWhiteUi100,
                                  fontWeight: FontWeight.w400,
                                  fontSize: size.size18.sp,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: color.greyWhiteUi100,
                            height: size.size1.dp,
                          ),
                        ],
                      ),
                    ),
                  ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.showCurrentLocation != null &&
                              widget.allOptionTitle != null)
                            Padding(
                              padding: EdgeInsets.only(
                                left: size.size21.dp,
                                top: size.size42.dp,
                              ),
                              child: Text(
                                widget.allOptionTitle!,
                                style: textStyle.h414pxRegular.copyWith(
                                  color: color.clrPrimaryBlue80,
                                  fontWeight: FontWeight.w400,
                                  fontSize: size.size14.sp,
                                ),
                              ),
                            ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (final context, final i) => Column(
                              children: [
                                DropdownBottomsheetListTile(
                                  items: _list,
                                  i: i,
                                  onItemSelect: widget.onItemSelect,
                                ),
                              ],
                            ),
                            separatorBuilder: (final context, final index) =>
                                Divider(
                              color: color.greyWhiteUi100,
                              height: size.size1.dp,
                            ),
                            itemCount: _list.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.bottomContent != null)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.bottomContent!,
                ],
              ),
            ),
        ],
      ),
    );
  }
}
