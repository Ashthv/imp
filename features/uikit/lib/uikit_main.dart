import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';
import 'package:tcs_dff_route/route_content.dart';
import 'package:tcs_dff_types/config.dart';

import 'aadharcard_text_screen.dart';
import 'accordian_screen.dart';
import 'account_card_screen.dart';
import 'account_field_screen.dart';
import 'account_no_mpin_screen.dart';
import 'amount_field_screen.dart';
import 'amount_fund_transfer_textfield_screen.dart';
import 'app_bar/demo_default_app_bar.dart';
import 'app_bar/demo_icon_sub_section_app_bar.dart';
import 'app_bar/demo_progress_app_bar.dart';
import 'app_bar/demo_search_app_bar.dart';
import 'app_sizer_screen.dart';
import 'appbar_screen.dart';
import 'badge_screen.dart';
import 'bank_account_and_available_amount_details_screen.dart';
import 'bank_account_radio_screen.dart';
import 'bank_card_screen.dart';
import 'banner_cardview_screen.dart';
import 'banner_detail_description_card_screen.dart';
import 'bill_payment_card_screen.dart';
import 'bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'bottomsheet_template_screen.dart';
import 'branch_location_widget_screen.dart';
import 'button_variants_screen.dart';
import 'card_with_image_title_screen.dart';
import 'cardview_screen.dart';
import 'checkbox_title_screen.dart';
import 'checkbox_title_subtitle_card_screen.dart';
import 'choose_language_card_screen.dart';
import 'circular_loading_screen.dart';
import 'common_scaffold_screen.dart';
import 'countrycode_screen.dart';
import 'credit_card_screen.dart';
import 'creditcard_accordian_screen.dart';
import 'date_picker_screen.dart';
import 'debit_card_screen.dart';
import 'divider_line_screen.dart';
import 'dropdown_field_screen.dart';
import 'file_uploader_screen.dart';
import 'filter_field_screen.dart';
import 'footer_notewidget_screen.dart';
import 'footer_stepper_variants_screen.dart';
import 'grid_carousel_screen.dart';
import 'header_with_text_input_slider_screen.dart';
import 'icon_content_card_screen.dart';
import 'icon_title_subtitle_card_screen.dart';
import 'icon_title_subtitle_screen.dart';
import 'icon_with_dotted_border_title_subtitle_screen.dart';
import 'icons_screen.dart';
import 'imagery_screen.dart';
import 'increment_decrement_switch_screen.dart';
import 'kebab_menu_screen.dart';
import 'language_dropdown_field_screen.dart';
import 'list_grid_widget_screen.dart';
import 'loan_details_card_screen.dart';
import 'lottie_animation_screen.dart';
import 'mask_usage.dart';
import 'mpin_screen.dart';
import 'note_widget_screen.dart';
import 'notificationwidget_screen.dart';
import 'otp_verification_bottomsheet_screen.dart';
import 'overlapcard_image_screen.dart';
import 'overlapping_cards_screen.dart';
import 'overlay_icon_title_subtitle_screen.dart';
import 'payment_card_screen.dart';
import 'product_description_screen.dart';
import 'profile_card_screen.dart';
import 'progress_bar_screen.dart';
import 'radio_button_icon_title_subtitle_card.dart';
import 'radio_button_screen.dart';
import 'recommended_card_widget_screen.dart';
import 'resend_otp_screen.dart';
import 'search_country_code_widget_screen.dart';
import 'search_dropdown_screen.dart';
import 'selfie_screen.dart';
import 'sim_slot_radiobutton_screen.dart';
import 'slider_screen.dart';
import 'snack_bar_screen.dart';
import 'status_screen.dart';
import 'stepper_screen.dart';
import 't_and_c_share_download_mail_screen.dart';
import 'tabs/full_page_tab_screen.dart';
import 'tabs/section_tab_screen.dart';
import 'tabs/tab_screen_icon.dart';
import 'tabs/tabs_screen.dart';
import 'tabs/tabs_screen_badge.dart';
import 'tabs/tabview_screen.dart';
import 'tag_screen.dart';
import 'terms_conditions_screen.dart';
import 'text_field_screen.dart';
import 'text_widget_screen.dart';
import 'textwidget_masking_screen.dart';
import 'timer_widget_screen.dart';
import 'timeslot_calendar_screen.dart';
import 'title_subtitle_screen.dart';
import 'toggle_tolltip_screen.dart';
import 'transaction_details_screen.dart';
import 'ui_kit_app.dart';
import 'verification_option_card_screen.dart';
import 'video_player_page.dart';
import 'video_tutorial_page.dart';
import 'webview/webview_html_screen.dart';
import 'webview/webview_screen.dart';
import 'webview/webview_url_screen.dart';

FeatureConfig featureConfig = FeatureConfig(
  name: 'uikit',
  routes: _routes,
  content: (final _, final __) => const UiKitApp(),
  appBar: (final routePath) {
    final appBar = switch (routePath) {
      'defaultAppBar' => DemoDefaultAppBar(),
      'progressAppBar' => DemoProgressAppBar(routePath: routePath),
      'iconSubSectionAppBar' => const DemoIconSubSectionAppBar(),
      'searchAppBar' => DemoSearchAppBar(controller: TextEditingController()),
      _ => DefaultAppBar(
          title: 'Ui Kit',
          subTitle: _getSubTitle(routePath),
        ),
    };

    return appBar as PreferredSizeWidget?;
  },
);

final _routes = [
  RouteContent(
    routePath: 'appBarScreen',
    content: (final _, final __) => const AppBarScreen(),
    routes: [
      RouteContent(
        routePath: 'defaultAppBar',
        content: (final _, final __) => const SizedBox.shrink(),
      ),
      RouteContent(
        routePath: 'progressAppBar',
        content: (final _, final __) => const SizedBox.shrink(),
      ),
      RouteContent(
        routePath: 'iconSubSectionAppBar',
        content: (final _, final __) => const SizedBox.shrink(),
      ),
      RouteContent(
        routePath: 'searchAppBar',
        content: (final _, final __) => const SizedBox.shrink(),
      ),
    ],
  ),
  RouteContent(
    routePath: 'aadharInputField',
    content: (final _, final __) => const AadharcardTextScreen(),
  ),
  RouteContent(
    routePath: 'cardViewScreen',
    content: (final _, final __) => const CardViewScreen(),
  ),
  RouteContent(
    routePath: 'mPinScreen',
    content: (final _, final __) => const MPinScreen(),
  ),
  RouteContent(
    routePath: 'resendOtpScreen',
    content: (final _, final __) => const ResendOtpScreen(),
  ),
  RouteContent(
    routePath: 'bankCardScreen',
    content: (final _, final __) => const CardScreen(),
  ),
  RouteContent(
    routePath: 'imageryScreen',
    content: (final _, final __) => const ImageryScreen(),
  ),
  RouteContent(
    routePath: 'profileCardScreen',
    content: (final _, final __) => const ProfileCardScreen(),
  ),
  RouteContent(
    routePath: 'sliderScreen',
    content: (final _, final __) => const SliderScreen(),
  ),
  RouteContent(
    routePath: 'datePickerScreen',
    content: (final _, final __) => const DatePickerScreen(),
  ),
  RouteContent(
    routePath: 'bottomNavBarScreen',
    content: (final _, final __) => const BottomNavBarScreen(),
  ),
  RouteContent(
    routePath: 'amountFundTransferTextfieldScreen',
    content: (final _, final __) => const AmountFundTransferTextfieldScreen(),
  ),
  RouteContent(
    routePath: 'textFieldScreen',
    content: (final _, final __) => const TextFieldScreen(),
  ),
  RouteContent(
    routePath: 'accordianScreen',
    content: (final _, final __) => const AccordianScreen(),
  ),
  RouteContent(
    routePath: 'iconsScreen',
    content: (final _, final __) => const IconsScreen(),
  ),
  RouteContent(
    routePath: 'statusTypesScreen',
    content: (final _, final __) => const StatusTypesScreen(),
  ),
  RouteContent(
    routePath: 'tagScreen',
    content: (final _, final __) => const TagScreen(),
  ),
  RouteContent(
    routePath: 'snackBarScreen',
    content: (final _, final __) => const SnackBarScreen(),
  ),
  RouteContent(
    routePath: 'toggle',
    content: (final _, final __) => const Toggletooltip(),
  ),
  RouteContent(
    routePath: 'tabSwitch',
    content: (final _, final __) => const TabviewScreen(),
    routes: [
      RouteContent(
        routePath: 'tabs',
        content: (final _, final __) => const TabsScreen(),
      ),
      RouteContent(
        routePath: 'tabsWithIcon',
        content: (final _, final __) => const TabScreenIcon(),
      ),
      RouteContent(
        routePath: 'fullPageTab',
        content: (final _, final __) => const FullPageTabScreen(),
      ),
      RouteContent(
        routePath: 'tabsWithBadge',
        content: (final _, final __) => const TabsScreenBadge(),
      ),
      RouteContent(
        routePath: 'sectionTab',
        content: (final _, final __) => const SectionTabScreen(),
      ),
    ],
  ),
  RouteContent(
    routePath: 'titleSubtitle',
    content: (final _, final __) => const TitleSubtitleScreen(),
  ),
  RouteContent(
    routePath: 'button',
    content: (final _, final __) => const ButtonVariantsScreen(),
  ),
  RouteContent(
    routePath: 'checkboxTitle',
    content: (final _, final __) => const CheckboxTitleScreen(),
  ),
  RouteContent(
    routePath: 'fileUploader',
    content: (final _, final __) => const FileUploaderScreen(),
  ),
  RouteContent(
    routePath: 'iconTitleSubtitle',
    content: (final _, final __) => const IconTitleSubtitleScreen(),
  ),
  RouteContent(
    routePath: 'timeSlotCalendar',
    content: (final _, final __) => const TimeSlotCalendarScreen(),
  ),
  RouteContent(
    routePath: 'progressBar',
    content: (final _, final __) => const ProgressBarScreen(),
  ),
  RouteContent(
    routePath: 'radioButtonScreen',
    content: (final _, final __) => const RadioButtonScreen(),
  ),
  RouteContent(
    routePath: 'overlayIconTitleSubtitleScreen',
    content: (final _, final __) => const OverlayIconTitleSubtitleScreeen(),
  ),
  RouteContent(
    routePath: 'simCardScreen',
    content: (final _, final __) => const SimCardRadioButtonScreen(),
  ),
  RouteContent(
    routePath: 'paymentCardScreen',
    content: (final _, final __) => const PaymentCardScreen(),
  ),
  RouteContent(
    routePath: 'otpDialog',
    content: (final _, final __) => const OtpVerificationBottomsheetScreen(),
  ),
  RouteContent(
    routePath: 'termsConditionScreen',
    content: (final _, final __) => const TermsConditionsScreen(),
  ),
  RouteContent(
    routePath: 'textWidget',
    content: (final _, final __) => const TextWidgetScreen(),
  ),
  RouteContent(
    routePath: 'selfieWidget',
    content: (final _, final __) => const SelfieScreen(),
  ),
  RouteContent(
    routePath: 'filterField',
    content: (final _, final __) => const FilterFieldScreen(),
  ),
  RouteContent(
    routePath: 'checkboxTitleSubtitleCard',
    content: (final _, final __) => const CheckboxTitleSubtitleCardScreen(),
  ),
  RouteContent(
    routePath: 'incrementDecrementSwitch',
    content: (final _, final __) => const IncrementDecrementSwitchScreen(),
  ),
  RouteContent(
    routePath: 'videoTutorialPage',
    content: (final _, final __) => const VideoTutorialPage(),
    routes: [
      RouteContent(
        routePath: 'videoPlayer',
        content: (final context, final state) {
          final videoConfig = state.extra! as VideoPlayerConfig;
          return VideoPlayerPage(
            title: videoConfig.title,
            videoLink: videoConfig.videoLink,
          );
        },
      ),
    ],
  ),
  RouteContent(
    routePath: 'iconTitleSubtitleCardScreen',
    content: (final _, final __) => const IconTitleSubtitleCardScreen(),
  ),
  RouteContent(
    routePath: 'timerWidget',
    content: (final _, final __) => const TimerWidgetScreen(),
  ),
  RouteContent(
    routePath: 'overlappingCardsScreen',
    content: (final _, final __) => OverlappingCardsScreen(),
  ),
  RouteContent(
    routePath: 'radioTitleSubtitleCard',
    content: (final _, final __) =>
        const RadioButtonIconTitleSubtitleCardScreen(),
  ),
  RouteContent(
    routePath: 'accountcardWidget',
    content: (final _, final __) => const AccountCardScreen(),
  ),
  RouteContent(
    routePath: 'countryCode',
    content: (final _, final __) => const CountryCodeScreen(),
  ),
  RouteContent(
    routePath: 'overlappingCardImage',
    content: (final _, final __) => const OverlapCardImageScreen(),
  ),
  RouteContent(
    routePath: 'chooseLanguageCardScreen',
    content: (final _, final __) => ChooseLanguageScreen(),
  ),
  RouteContent(
    routePath: 'bottomSheetTemplate',
    content: (final _, final __) => const BottomsheetTemplateScreen(),
  ),
  RouteContent(
    routePath: 'verificationOptionCard',
    content: (final _, final __) => const VerificationOptionCardScreen(),
  ),
  RouteContent(
    routePath: 'recommenededCardWidget',
    content: (final _, final __) => const RecommendedCardWidgetScreen(),
  ),
  RouteContent(
    routePath: 'notificationWidget',
    content: (final _, final __) => const NotificationWidgetScreen(),
  ),
  RouteContent(
    routePath: 'maskUsage',
    content: (final _, final __) => const MaskUsageScreen(),
  ),
  RouteContent(
    routePath: 'searchCountryCodeWidget',
    content: (final _, final __) => const SearchCountryCodeWidgetScreen(),
  ),
  RouteContent(
    routePath: 'accountNumberTextField',
    content: (final _, final __) => const AccountFieldScreen(),
  ),
  RouteContent(
    routePath: 'amountTextField',
    content: (final _, final __) => const AmountFieldScreen(),
  ),
  RouteContent(
    routePath: 'webview',
    content: (final _, final __) => const WebviewScreen(),
    routes: [
      RouteContent(
        routePath: 'url',
        content: (final _, final __) => const WebviewUrlScreen(),
      ),
      RouteContent(
        routePath: 'html',
        content: (final _, final __) => const WebviewHtmlScreen(),
      ),
    ],
  ),
  RouteContent(
    routePath: 'noteWidget',
    content: (final _, final __) => const NoteWidgetScreen(),
  ),
  RouteContent(
    routePath: 'accountCard',
    content: (final _, final __) => const AccountCardScreen(),
  ),
  RouteContent(
    routePath: 'searchDropDownScreen',
    content: (final _, final __) => const SearchDropDownScreen(),
  ),
  RouteContent(
    routePath: 'productDescriptionBanner',
    content: (final _, final __) => const ProductDescriptionBannerScreen(),
  ),
  RouteContent(
    routePath: 'bannerCardViewScreen',
    content: (final _, final __) => const BannerCardViewScreen(),
  ),
  RouteContent(
    routePath: 'productDescriptionDetail',
    content: (final _, final __) => const BannerDetailDescriptionScreen(),
  ),
  RouteContent(
    routePath: 'footerNotewidgetScreen',
    content: (final _, final __) => const FooterNotewidgetScreen(),
  ),
  RouteContent(
    routePath: 'gridViewCarousel',
    content: (final _, final __) => const GridCarouselScreen(),
  ),
  RouteContent(
    routePath: 'dropdownFieldScreen',
    content: (final _, final __) => const DropdownFieldScreen(),
  ),
  RouteContent(
    routePath: 'languageDropdownFieldScreen',
    content: (final _, final __) => const LanguageDropdownFieldScreen(),
  ),
  RouteContent(
    routePath: 'imageIconwithDottedCircle',
    content: (final _, final __) =>
        const IconWithDottedBorderTitleSubtitleScreen(),
  ),
  RouteContent(
    routePath: 'textWidgetMasking',
    content: (final _, final __) => const TextWidgetMaskingScreen(),
  ),
  RouteContent(
    routePath: 'dividerLineScreen',
    content: (final _, final __) => const DividerLineScreen(),
  ),
  RouteContent(
    routePath: 'stepperWidget',
    content: (final _, final __) => const StepperScreen(),
  ),
  RouteContent(
    routePath: 'cardWithImageTitle',
    content: (final _, final __) => const CardWithImageAndTitleScreen(),
  ),
  RouteContent(
    routePath: 'branchLocationWidget',
    content: (final _, final __) => const BranchLocationWidgetScreen(),
  ),
  RouteContent(
    routePath: 'debitCardScreen',
    content: (final _, final __) => const DebitCardScreen(),
  ),
  RouteContent(
    routePath: 'footerStepperVariants',
    content: (final _, final __) => const FooterStepperVariantsScreen(),
  ),
  RouteContent(
    routePath: 'lottieAnimation',
    content: (final _, final __) => LottieAnimationScreen(),
  ),
  RouteContent(
    routePath: 'accountNoMpin',
    content: (final _, final __) => const AccountNoMpinScreen(),
  ),
  RouteContent(
    routePath: 'radioImageTitleSubtitleScreen',
    content: (final _, final __) =>
        const RadioButtonIconTitleSubtitleCardScreen(),
  ),
  RouteContent(
    routePath: 'baseScaffold',
    content: (final _, final __) => const CommonScaffoldScreen(),
  ),
  RouteContent(
    routePath: 'creditcardAccordianScreen',
    content: (final _, final __) => const CreditCardAccordianScreen(),
  ),
  RouteContent(
    routePath: 'radioImageTitleSubtitleScreen',
    content: (final _, final __) =>
        const RadioButtonIconTitleSubtitleCardScreen(),
  ),
  RouteContent(
    routePath: 'kebabMenuScreen',
    content: (final _, final __) => const KebabMenuScreen(),
  ),
  RouteContent(
    routePath: 'creditCardComponent',
    content: (final _, final __) => const CreditCardScreen(),
  ),
  RouteContent(
    routePath: 'circularLoadingScreen',
    content: (final _, final __) => const CircularLoadingScreen(),
  ),
  RouteContent(
    routePath: 'headerTextInputSlider',
    content: (final _, final __) => const HeaderWithTextInputSliderScreen(),
  ),
  RouteContent(
    routePath: 'iconContentCard',
    content: (final _, final __) => const IconContentCardScreen(),
  ),
  RouteContent(
    routePath: 'badgeWidget',
    content: (final _, final __) => BadgeScreen(),
  ),
  RouteContent(
    routePath: 'LoanDetailsCardScreen',
    content: (final _, final __) => const LoanDetailsCardScreen(),
  ),
  RouteContent(
    routePath: 'DownloadTermsAndConditionsScreen',
    content: (final _, final __) => const TAndCShareDownloadMailScreen(),
  ),
  RouteContent(
    routePath: 'BankAccountDetailsAndAvailableAmountScreen',
    content: (final _, final __) =>
        const BankAccountDetailsAndAvailableAmountScreen(),
  ),
  RouteContent(
    routePath: 'listGridWidgetScreen',
    content: (final _, final __) => const ListGridWidgetScreen(),
  ),
  RouteContent(
    routePath: 'billPaymentCard',
    content: (final _, final __) => const BillPaymentScreen(),
  ),
  RouteContent(
    routePath: 'TransactionDetailsScreen',
    content: (final _, final __) => const TransactionDetailsScreen(),
  ),
  RouteContent(
    routePath: 'appSizer',
    content: (final _, final __) => const AppSizerScreen(),
  ),
  RouteContent(
    routePath: 'bankAccountRadioButton',
    content: (final _, final __) => const BankAccountRadioButtonScreen(),
  ),
];

String? _getSubTitle(final String routePath) => switch (routePath) {
      'appBarScreen' => 'App Bar',
      'cardViewScreen' => 'Card View',
      'mPinScreen' => 'M-Pin',
      'imageryScreen' => 'Imagery',
      'bankCardScreen' => 'Bank Card',
      'numPadScreen' => 'Num Pad',
      'sliderScreen' => 'Slider',
      'datePickerScreen' => 'Date Picker',
      'bottomNavBarScreen' => 'Bottom Nav Bar',
      'amountFundTransferTextfieldScreen' => 'Amount Fund Transfer Textfield',
      'textFieldScreen' => 'Text Field',
      'accordianScreen' => 'Accordian',
      'iconsScreen' => 'Icons',
      'tagScreen' => 'Status Tag',
      'snackBarScreen' => 'Snack Bar',
      'simCardScreen' => 'Sim Card',
      'radioButtonScreen' => 'Radio Button',
      'profileCardScreen' => 'Profile Card',
      'checkboxWidget' => 'Checkbox Widget',
      'videoTutorialPage' => 'Video Tutorials',
      'videoPlayer' => 'Video Player',
      'timeSlotCalendar' => 'Time Slot And Calendar',
      'aadharInputField' => 'AadharNumber Input Field',
      'otpDialog' => 'OTP Dialog',
      'termsConditionScreen' => 'Terms & Conditions',
      'timerWidget' => 'Timer',
      'textWidget' => 'Text Widget',
      'overlayIconTitleSubtitle' => 'Overlay Icon Title Subtitle',
      'countryCode' => 'Country Code',
      'checkboxTitleSubtitleCard' => 'Checkbox Title Subtitle Card',
      'bottomSheetTemplate' => 'Bottomsheet Template',
      'notificationWidget' => 'Notification Widget',
      'verificationOptionCard' => 'Verification Option Card',
      'searchCountryCodeWidget' => 'Search Country Code Widget',
      'webview' => 'WebView',
      'url' => 'WebView - Url',
      'html' => 'WebView - Html',
      'paymentCardScreen' => 'Payment Card',
      'accountNumberTextField' => 'Account Number Text Field',
      'amountTextField' => 'Amount number text field',
      'bannerCardViewScreen' => 'Banner Card View',
      'searchDropDownScreen' => 'Search DropDown',
      'productDescriptionBanner' => 'Product Description Banner',
      'productDescriptionDetail' => 'Product Description Detail',
      'accountCard' => 'Account Card',
      'dropdownFieldScreen' => 'Dropdown Field',
      'imageIconwithDottedCircle' => 'Image Icon with Dotted Circle',
      'textWidgetMasking' => 'Text Widget Masking',
      'dividerLineScreen' => 'DividerLine',
      'debitCardScreen' => 'Debit Card',
      'cardWithImageTitle' => 'Card With Image And Title',
      'branchLocationWidget' => 'Branch Location Widget',
      'footerStepperVariants' => 'Footer Stepper Variants',
      'lottieAnimation' => 'Lottie Animation',
      'accountNoMpin' => 'Account Number with MPIN',
      'statustypes' => 'Status Types',
      'kebabMenuScreen' => 'Kebab Menu',
      'creditCardComponent' => 'Credit Card Component',
      'languageDropdownFieldScreen' => 'Language Dropdown Field',
      'circularLoadingScreen' => 'Circular Loading Widget',
      'scheduledDateButton' => 'Scheduled Date Button',
      'headerTextInputSlider' => 'Header Text Input Slider',
      'iconContentCard' => 'Icon Content Card',
      'badgeWidget' => 'Badge Widget',
      'downloadTermsAndConditions' => 'Download Terms And Conditions Screen',
      'transactionDetailsScreen' => 'Transaction Details Screen',
      'radioImageTitleSubtitleScreen' => 'Radio Button Card',
      'incrementDecrementSwitch' => 'Increment Decrement Switch',
      'resendOtpScreen' => 'Resend Otp',
      'statusTypesScreen' => 'Status Types',
      'baseScaffold' => 'Base Scaffold',
      'filterField' => 'Filter Field',
      'button' => 'Buttons',
      'toggle' => 'Toggle Button',
      'checkboxTitle' => 'Checkbox',
      'tabSwitch' => 'Tabs',
      'titleSubtitle' => 'Title Subtitle',
      'fileUploader' => 'File Uploader',
      'iconTitleSubtitle' => 'Icon Title Subtitle',
      'iconTitleSubtitleCardScreen' => 'Icon Title Subtitle Card',
      'overlappingCardsScreen' => 'Overlapping Cards',
      'radioTitleSubtitleCard' => 'Radio Title Subtitle Card',
      'chooseLanguageCardScreen' => 'choose Language Card',
      'overlappingCardImage' => 'overlapping Card Image',
      'maskUsage' => 'Mask Usage',
      'selfieWidget' => 'Selfie Widget',
      'noteWidget' => 'Note Widget',
      'stepperWidget' => 'Stepper Widget',
      'recommenededCardWidget' => 'Recommeneded Card Widget',
      'gridViewCarousel' => 'Grid View Carousel',
      'footerNotewidgetScreen' => 'Footer Note Widget',
      'LoanDetailsCardScreen' => 'Loan Details Card Screen',
      'listGridWidgetScreen' => 'List Grid Widget',
      'billPaymentCard' => 'Bill Payment Card',
      'tabs' => 'Tabs',
      'tabsWithIcon' => 'Tabs With Icon',
      'tabsWithBadge' => 'Tabs With Badge',
      'fullPageTab' => 'Full Page Tab',
      'sectionTab' => 'Section Tab',
      'BankAccountDetailsAndAvailableAmountScreen' =>
        'Bank AccountDetails And Available Amount Screen',
      'appSizer' => 'App Sizer',
      'bankAccountRadioButton' => 'Bank Account Radio',
      _ => null,
    };
