import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/icon_widget.dart';
import '../../foundation/input_field/textfield_widget.dart';
import 'chip_widget.dart';

class Country {
  int id;
  String country;
  String code;
  StatusCode? status;

  Country({
    required this.id,
    required this.country,
    required this.code,
    this.status = StatusCode.normal,
  });
}

class SearchCountryCodeWidget extends StatefulWidget {
  final Function(Country selectedCountry) selectedCountry;
  final String label;

  final String suggestedCountryText;
  final List<Country> countryList;

  SearchCountryCodeWidget({
    super.key,
    required this.selectedCountry,
    required this.suggestedCountryText,
    required this.label,
    required this.countryList,
  });

  @override
  State<SearchCountryCodeWidget> createState() => _BottomSheetChipsState();
}

class _BottomSheetChipsState extends State<SearchCountryCodeWidget> {
  TextEditingController usernameController = TextEditingController();

  List<Country> _list = [];

  Country? selectedChip;

  @override
  void initState() {
    _list = widget.countryList;
    selectedChip = widget.countryList.first;
    super.initState();
  }

  void _filterList(final String searchText) {
    setState(() {
      _list = widget.countryList
          .where(
            (final element) => element.country.toLowerCase().contains(
                  searchText.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return Container(
      padding: EdgeInsets.only(top: size.size10.dp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWidget(
            controller: usernameController,
            label: widget.label,
            onChanged: _filterList,
            suffixWidget: InkWell(
              onTap: () {
                usernameController.clear();
                setState(() {
                  _list = widget.countryList;
                });
              },
              child: IconWidget(
                iconName:
                    'packages/tcs_dff_design_system/assets/images/close.png',
                iconSize: IconSize.small,
                iconColor: color.clrPrimaryPurple,
              ),
            ),
          ),
          SizedBox(
            height: size.size10.dp,
          ),
          Container(
            margin: EdgeInsets.only(
              left: size.size22.dp,
              right: size.size22.dp,
              top: size.size12.dp,
              bottom: size.size12.dp,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.suggestedCountryText,
                  style: textStyle.h414pxRegular.copyWith(
                    color: color.greyDarkGrey30,
                  ),
                ),
                SizedBox(
                  height: size.size13.dp,
                ),
                Wrap(
                  spacing: size.size8.dp,
                  children: _list
                      .map(
                        (final country) => ChipWidget(
                          label: country.country,
                          onSelected: (final bool selected) {
                            setState(() {
                              if (selected) {
                                selectedChip = country;
                                usernameController.text = country.country;
                                widget.selectedCountry(country);
                              } else {
                                selectedChip = null;
                              }
                            });
                          },
                          staus: selectedChip?.status,
                          isSelected: selectedChip == country,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }
}
