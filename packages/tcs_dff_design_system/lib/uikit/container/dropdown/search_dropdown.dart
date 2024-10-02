import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../theme/theme_extensions/color_extension.dart';
import '../../../theme/theme_extensions/size_extension.dart';
import '../../../theme/theme_extensions/text_style_extension.dart';
import '../../../utils/searchbar_border_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/icon_widget.dart';

class SearchDropDown extends StatefulWidget {
  final String labelText;
  final bool isSearchFieldEnabled;
  final String? errorMessage;
  final String? searchLoaderText;
  final int searchBeginCount;
  final SearchbarBorderType borderType;
  final Function(String) onItemSelection;
  final Future<List<String>> Function(String) onChange;
  final Widget? suffixIcon;

  SearchDropDown({
    required this.labelText,
    required this.isSearchFieldEnabled,
    this.errorMessage,
    this.searchLoaderText,
    this.searchBeginCount = 1,
    required this.onItemSelection,
    required this.onChange,
    this.borderType = SearchbarBorderType.border,
    super.key,
    this.suffixIcon,
  });

  @override
  State<SearchDropDown> createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown>
    with TickerProviderStateMixin {
  String? _textFieldValue;
  String? _selectedItem;
  TextEditingController textEditController = TextEditingController();
  OverlayEntry? _overlayEntry;
  OverlayState? overlayState;
  GlobalKey globalKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  int? itemLength;
  List<String> searchResultList = [];
  List<String> filteredList = [];
  bool isSearchingLoaderVisible = true;

  @override
  void initState() {
    super.initState();
    overlayState = Overlay.of(context);
  }

  @override
  void dispose() {
    if (!mounted) {
      textEditController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;

    //In this we are creating base of search bar and according to the enum
    //border or borderless we are setting prefix and suffix icon
    //also on change we are giving call back on the screen and getting filtered
    // from the screen
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            style: textStyle.labelSmall14Medium.copyWith(
              height: 1,
              fontSize: size.size21.sp,
              color: color.greyBlackUi10,
              fontWeight: FontWeight.w400,
            ),
            cursorHeight: 25,
            onChanged: (final value) {
              getUpdatedFilterList(size, textStyle, color, value);
            },
            controller: textEditController,
            decoration: InputDecoration(
              focusedBorder: getFocussedBorder(size, color),
              enabledBorder: getEnabledBorder(size, color),
              errorBorder: getErrorBorder(size, color),
              border: getBorder(size, color),
              labelText: widget.labelText,
              hintText: widget.labelText,
              prefixIcon: widget.borderType == SearchbarBorderType.border
                  ? getPrefixSearchIcon(color)
                  : null,
              prefixIconColor: widget.borderType == SearchbarBorderType.border
                  ? color.silverDark
                  : null,
              suffixIcon: widget.suffixIcon?? getSuffixSearchIcon(color),
            ),
          ),
        ),
        getErrorOrSearchLoaderText(size, textStyle, color),
      ],
    );
  }

  //Creating Overlay to show filtered array
  OverlayEntry _createSearchOverlay() {
    final size = context.theme.appSize;
    final renderBox = context.findRenderObject() as RenderBox;
    final rendorSize = renderBox.size;

    return OverlayEntry(
      builder: (final context) {
        final textStyle = context.theme.appTextStyles;
        final color = context.theme.appColor;
        return Positioned(
          width: rendorSize.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(size.size1.dp, rendorSize.height + 7),
            child: Material(
              elevation: size.size5.dp,
              borderRadius: BorderRadius.all(Radius.circular(size.size15.dp)),
              child: ListView.builder(
                itemCount: filteredList.length,
                shrinkWrap: true,
                itemBuilder: (final context, final index) => Container(
                  alignment: Alignment.center,
                  color: context.theme.appColor.greyWhiteUi100,
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        _selectedItem = filteredList[index];
                      });
                      widget.onItemSelection(_selectedItem!);
                      removeOverlay();
                    },
                    title: Padding(
                      padding: EdgeInsets.only(
                        top: size.size15.dp,
                        right: size.size15.dp,
                        bottom: size.size15.dp,
                      ),
                      child: Text(
                        filteredList[index],
                        style: textStyle.bodyCopy2Medium16SemiBold.copyWith(
                          color: color.greyBlackUi10,
                          fontSize: size.size16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //  ),
        );
      },
    );
  }

  Visibility getErrorOrSearchLoaderText(
    final AppSizeExtension size,
    final AppTextStyleExtension textStyle,
    final AppColorsExtension color,
  ) {
    var isSearchLoaderEnable = false;
    String? loadingText;

    if (isSearchingLoaderVisible == true &&
        widget.searchLoaderText != null &&
        textEditController.text.isNotEmpty) {
      isSearchLoaderEnable = true;
      loadingText = widget.searchLoaderText ?? '';
    } else if (widget.errorMessage != null &&
        filteredList.isEmpty &&
        textEditController.text.isNotEmpty) {
      loadingText = widget.errorMessage ?? '';
    }

    return Visibility(
      visible: loadingText != null,
      //maintainState: true,
      child: Padding(
        padding: EdgeInsets.only(left: size.size10.dp, top: size.size8.dp),
        child: Text(
          loadingText ?? '',
          style: isSearchLoaderEnable
              ? textStyle.h414pxRegular.copyWith(
                  color: color.clrPrimaryPurple,
                  fontWeight: FontWeight.w400,
                )
              : textStyle.h414pxRegular.copyWith(
                  color: color.silverDark,
                  fontWeight: FontWeight.w400,
                ),
        ),
      ),
    );
  }

  InputBorder getFocussedBorder(
    final AppSizeExtension size,
    final AppColorsExtension color,
  ) {
    if (widget.borderType == SearchbarBorderType.border) {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: color.clrPrimaryPurple30,
          width: size.size2.dp,
        ),
        borderRadius: BorderRadius.circular(size.size6.dp),
      );
    } else {
      return UnderlineInputBorder(
        borderSide: BorderSide(
          color: color.clrPrimaryPurple30,
          width: size.size2.dp,
        ),
        borderRadius: BorderRadius.circular(size.size6.dp),
      );
    }
  }

  InputBorder getEnabledBorder(
    final AppSizeExtension size,
    final AppColorsExtension color,
  ) {
    if (widget.borderType == SearchbarBorderType.border) {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: color.greyLighterGrey70,
          width: size.size2.dp,
        ),
        borderRadius: BorderRadius.circular(size.size6.dp),
      );
    } else {
      return UnderlineInputBorder(
        borderSide: BorderSide(
          color: color.greyLighterGrey70,
          width: size.size2.dp,
        ),
        borderRadius: BorderRadius.circular(size.size6.dp),
      );
    }
  }

  InputBorder getErrorBorder(
    final AppSizeExtension size,
    final AppColorsExtension color,
  ) {
    if (widget.borderType == SearchbarBorderType.border) {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: color.statRedDefault,
          width: size.size2.dp,
        ),
        borderRadius: BorderRadius.circular(size.size6.dp),
      );
    } else {
      return UnderlineInputBorder(
        borderSide: BorderSide(
          color: color.statRedDefault,
          width: size.size2.dp,
        ),
        borderRadius: BorderRadius.circular(size.size6.dp),
      );
    }
  }

  InputBorder getBorder(
    final AppSizeExtension size,
    final AppColorsExtension color,
  ) {
    if (widget.borderType == SearchbarBorderType.border) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(size.size6.dp),
        borderSide: BorderSide(
          // color: color.primaryOpacity90,
          width: size.size2.dp,
        ),
      );
    } else {
      return UnderlineInputBorder(
        borderRadius: BorderRadius.circular(size.size6.dp),
        borderSide: BorderSide(
          // color: color.primaryOpacity90,
          width: size.size2.dp,
        ),
      );
    }
  }

  Widget getSuffixSearchIcon(final AppColorsExtension color) => InkWell(
        onTap: () {
          setState(() {
            if (_textFieldValue!.isNotEmpty) {
              clearText();
            }
            // _textFieldValue != '' || _textFieldValue == null
            //     ? clearText()
            //     : null;
            _textFieldValue = null;
          });
        },
        splashColor: color.transparent,
        highlightColor: color.transparent,
        child: widget.borderType == SearchbarBorderType.borderless
            ? Icon(
                _textFieldValue == '' || _textFieldValue == null
                    ? Icons.search
                    : Icons.close,
                color: color.clrPrimaryPurple30,
              )
            : Icon(
                _textFieldValue == '' || _textFieldValue == null
                    ? null
                    : Icons.close,
                color: color.clrPrimaryPurple30,
              ),
      );

  Widget getPrefixSearchIcon(final AppColorsExtension color) =>
      const IconWidget(
        package: 'tcs_dff_design_system',
        iconName: 'assets/images/search.png',
        iconSize: IconSize.small,
      );

  Future<void> getUpdatedFilterList(
    final AppSizeExtension size,
    final AppTextStyleExtension textStyle,
    final AppColorsExtension color,
    final String textValue,
  ) async {
    setState(() {
      isSearchingLoaderVisible = true;
      removeOverlay();
    });
    searchResultList = await widget.onChange(textValue);
    setState(() {
      _printLatestValue(size, textStyle, color);
      _textFieldValue = textValue;
    });
  }

  void _printLatestValue(
    final AppSizeExtension size,
    final AppTextStyleExtension textStyle,
    final AppColorsExtension color,
  ) {
    final text = textEditController.text;
    if (text.characters.isNotEmpty) {
      filteredList = searchResultList;
      isSearchingLoaderVisible = false;
      getErrorOrSearchLoaderText(size, textStyle, color);
      removeOverlay();
      _overlayEntry = _createSearchOverlay();
      overlayState!.insert(_overlayEntry!);
    } else {
      removeOverlay();
    }
  }

  void clearText() {
    removeOverlay();
    textEditController.clear();
  }

  void removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
