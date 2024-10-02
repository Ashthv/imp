import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';

import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_route/route_navigator.dart';

class UiKitApp extends StatefulWidget {
  const UiKitApp({super.key});

  @override
  State<UiKitApp> createState() => _UiKitAppState();
}

class _UiKitAppState extends State<UiKitApp> {
  List<ComponentModel> componentModel = [];

  Widget appBarTitle = const Text(
    'SEARCH COMPONENT ',
    style: TextStyle(color: Color(0xff5553aa)),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Color(0xff5553aa),
  );

  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();

  late bool _isSearching;
  String _searchText = '';

  @override
  void initState() {
    _isSearching = false;
    init();

    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = '';
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });

    super.initState();
  }

  void init() {
    for (final component in listOfComponent.entries) {
      componentModel.add(
        ComponentModel(
          componentName: component.key,
          navigationTo: component.value,
        ),
      );
    }
  }

  AppBar buildBar(final BuildContext context) => AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (actionIcon.icon == Icons.search) {
                  actionIcon = Icon(
                    Icons.close,
                    color: context.theme.appColor.clrPrimaryBlue,
                  );
                  appBarTitle = TextField(
                    controller: _searchQuery,
                    style: TextStyle(
                      fontSize: 15,
                      color: context.theme.appColor.clrPrimaryBlue,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: context.theme.appColor.clrPrimaryBlue,
                      ),
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: context.theme.appColor.clrPrimaryBlue,
                      ),
                    ),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ],
      );

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      actionIcon = Icon(
        Icons.search,
        color: context.theme.appColor.clrPrimaryBlue,
      );
      appBarTitle = Text(
        'Search Component',
        style: TextStyle(color: context.theme.appColor.clrPrimaryBlue),
      );
      _isSearching = false;
      _searchQuery.clear();
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: buildBar(context),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: _isSearching ? _buildSearchList() : _buildList(),
        ),
      );

  List<Component> _buildList() => componentModel.map(Component.new).toList();

  List<Component> _buildSearchList() {
    if (_searchText.isEmpty) {
      return componentModel.map(Component.new).toList();
    } else {
      final _searchList = <ComponentModel>[];
      for (var i = 0; i < componentModel.length; i++) {
        final model = componentModel.elementAt(i);
        if (model.componentName!
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _searchList.add(model);
        }
      }
      return _searchList.map(Component.new).toList();
    }
  }
}

class ComponentModel {
  final String? componentName;
  final String? navigationTo;
  ComponentModel({this.componentName, this.navigationTo});
}

class Component extends StatelessWidget {
  final ComponentModel model;
  Component(this.model);
  @override
  Widget build(final BuildContext context) => InkWell(
        onTap: () {
          RouteNavigator.push(
            context,
            '/uikit/${model.navigationTo}',
          );
        },
        child: Padding(
          padding: EdgeInsets.all(8.0.dp),
          child: Text(
            model.componentName.toString(),
            style: TextStyle(
              fontSize: 20.dp,
              color: Colors.black,
            ),
          ),
        ),
      );
}

// add your "componentname" with "navigationScreen"
Map<String, String> listOfComponent = {
  'App bar': 'appBarScreen',
  'Aadhar Number Input Field': 'aadharInputField',
  'Card View': 'cardViewScreen',
  'Imagery': 'imageryScreen',
  'Profile Card': 'profileCardScreen',
  'Slider': 'sliderScreen',
  'Date Picker': 'datePickerScreen',
  'Text Field': 'textFieldScreen',
  'Tab Switch': 'tabSwitch',
  'Accordian': 'accordianScreen',
  'Icons': 'iconsScreen',
  'Snack Bar': 'snackBarScreen',
  'Radio': 'radioButtonScreen',
  'Payment Card': 'paymentCardScreen',
  'Overlay Icon Title Subtitle': 'overlayIconTitleSubtitleScreen',
  'Sim Card': 'simCardScreen',
  'Toggle Button': 'toggle',
  'TimeSlot Calendar': 'timeSlotCalendar',
  'Check Box Title': 'checkboxTitle',
  'Title Subtitle': 'titleSubtitle',
  'Buttons': 'button',
  'File Uploader': 'fileUploader',
  'Icon Title Subtitle': 'iconTitleSubtitle',
  'OTP Dialog': 'otpDialog',
  'Terms Conditions': 'termsConditionScreen',
  'Audio and VideoTutorial Page': 'videoTutorialPage',
  'Text Widget': 'textWidget',
  'Icon Title SubCard': 'iconTitleSubtitleCardScreen',
  'Overlapping Card Carousel': 'overlappingCardsScreen',
  'Radio Title Subtitle Card': 'radioTitleSubtitleCard',
  'choose Language Card': 'chooseLanguageCardScreen',
  'Country Code Text': 'countryCode',
  'overlapping Card Image': 'overlappingCardImage',
  'BottomSheet Template': 'bottomSheetTemplate',
  'Verification Option Card': 'verificationOptionCard',
  'Notification Widget': 'notificationWidget',
  'search Country Code Widget': 'searchCountryCodeWidget',
  'Timer': 'timerWidget',
  'Mask Usage': 'maskUsage',
  'Web View': 'webview',
  'Account Number TextField': 'accountNumberTextField',
  'Amount number Text Field': 'amountTextField',
  'Selfie Widget': 'selfieWidget',
  'Account card': 'accountCard',
  'Note Widget': 'noteWidget',
  'Stepper Widget': 'stepperWidget',
  'Search DropDown': 'searchDropDownScreen',
  'Recommeneded Card Widget': 'recommenededCardWidget',
  'Product Description Widget': 'productDescriptionBanner',
  'Banner Card': 'bannerCardViewScreen',
  'Product Description Detail': 'productDescriptionDetail',
  'Grid View Carousel': 'gridViewCarousel',
  'Bottom Nav Bar': 'bottomNavBarScreen',
  'Divider Line': 'dividerLineScreen',
  'Amount Fund Transfer Textfield': 'amountFundTransferTextfieldScreen',
  'Footer Note Widget': 'footerNotewidgetScreen',
  'Image icon with Dotted circle': 'imageIconwithDottedCircle',
  'Text Widget masking': 'textWidgetMasking',
  'Branch Location Widget': 'branchLocationWidget',
  'Card with Image & title': 'cardWithImageTitle',
  'Footer Stepper Variants': 'footerStepperVariants',
  'Account Number with MPIN': 'accountNoMpin',
  'Radio Button card': 'radioImageTitleSubtitleScreen',
  'Lottie Animation': 'lottieAnimation',
  'Checkbox Title Subtitle Card': 'checkboxTitleSubtitleCard',
  'Kebab Menu': 'kebabMenuScreen',
  'Dropdown Field': 'dropdownFieldScreen',
  'Increment Decrement Switch': 'incrementDecrementSwitch',
  'M-Pin': 'mPinScreen',
  'Resend Otp': 'resendOtpScreen',
  'Bank Card': 'bankCardScreen',
  'Status Type': 'statusTypesScreen',
  'Tag Type': 'tagScreen',
  'progressBar': 'Progress Bar',
  'Debit Card': 'debitCardScreen',
  'Credit Card Accordian': 'creditcardAccordianScreen',
  'Language Dropdown Field': 'languageDropdownFieldScreen',
  'FilterField': 'filterField',
  'Circular Loading Animation': 'circularLoadingScreen',
  'Header With Text Input With Slider': 'headerTextInputSlider',
  'Icon Content Card': 'iconContentCard',
  'Badge Widget': 'badgeWidget',
  'Credit Card component': 'creditCardComponent',
  'LoanDetailsCardScreen': 'LoanDetailsCardScreen',
  'Download Terms And Conditions Screen': 'DownloadTermsAndConditionsScreen',
  'Base Scaffold': 'baseScaffold',
  'ListGridWidgetScreen': 'listGridWidgetScreen',
  'Bill Payment Card': 'billPaymentCard',
  'Transaction Details Screen': 'TransactionDetailsScreen',
  'Bank Account Details And Available Amount Screen':
      'BankAccountDetailsAndAvailableAmountScreen',
  'App Sizer': 'appSizer',
  'Bank Account Radio Button': 'bankAccountRadioButton',
};
