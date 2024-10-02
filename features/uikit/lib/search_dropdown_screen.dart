import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';

class SearchDropDownScreen extends StatefulWidget {
  const SearchDropDownScreen({super.key});
  @override
  State<SearchDropDownScreen> createState() => _SearchDropDownScreenState();
}

class _SearchDropDownScreenState extends State<SearchDropDownScreen> {
  List<String> data = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grapes',
    'Honeydew',
    'Kiwi',
    'Lemon',
  ];

  List<String> searchResult = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: size.size10, left: size.size10),
        child: SearchDropDown(
          labelText: 'Search',
          isSearchFieldEnabled: true,
          searchLoaderText: 'Searching...',
          errorMessage: 'No record found',
          onItemSelection: (final selectedOption) {},
          onChange: searchLogic,
          borderType: SearchbarBorderType.borderless,
        ),
      ),
    );
  }

  Future<List<String>> searchLogic(final String text) async =>
      searchResult = data
          .where(
            (final item) => item.toLowerCase().contains(text.toLowerCase()),
          )
          .toList();
}
