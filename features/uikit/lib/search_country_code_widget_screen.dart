import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class SearchCountryCodeWidgetScreen extends StatefulWidget {
  const SearchCountryCodeWidgetScreen({super.key});

  @override
  State<SearchCountryCodeWidgetScreen> createState() =>
      _ChoiceChipScreenState();
}

class _ChoiceChipScreenState extends State<SearchCountryCodeWidgetScreen> {
  List<Country> countryList = [
    Country(
      id: 1,
      code: '+01',
      country: 'United States of America',
      status: StatusCode.suggested,
    ),
    Country(
      id: 2,
      code: '+02',
      country: 'Bangladesh',
    ),
    Country(
      id: 3,
      code: '+03',
      country: 'United Kingdom',
      status: StatusCode.suggested,
    ),
    Country(
      id: 4,
      code: '+04',
      country: 'Africa',
      status: StatusCode.disabled,
    ),
    Country(
      id: 5,
      code: '+05',
      country: 'United Arab Emirates',
      status: StatusCode.suggested,
    ),
    Country(
      id: 6,
      code: '+06',
      country: 'England',
      status: StatusCode.disabled,
    ),
    Country(
      id: 7,
      code: '+91',
      country: 'India',
    ),
  ];
  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final bottomsheetTemplateData = BottomsheetTemplateData(
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SearchCountryCodeWidget(
          countryList: countryList,
          label: locale.txt(key: 'countryCodeText'),
          suggestedCountryText: locale.txt(key: 'suggestedCountries'),
          selectedCountry: (final Country country) {
            print(country.country);
          },
        ),
      ),
      onCloseButtonTap: () {
        Navigator.pop(context);
      },
    );

    return Scaffold(
      body: ElevatedButton(
        child: Text(locale.txt(key: 'showTemplate')),
        onPressed: () {
          showBottomSheetModal(
            context,
            BottomsheetTemplate(
              bottomsheetTemplateData: bottomsheetTemplateData,
            ),
          );
        },
      ),
    );
  }
}
