import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/dropdown_menue_model.dart';
import '../../utils/sizer/app_sizer.dart';
import 'dropdown/language_dropdown_field.dart';
import 'webview/webview.dart';

class ConsentWidget extends StatefulWidget {
  final String url;
  final Function()? onCancel;
  final List<DropdownMenuModel>? dropdownMenuList;
  final dynamic Function(DropdownMenuModel)? onOptionSelect;
  final Widget bottomWidget;
  const ConsentWidget({
    super.key,
    this.onCancel,
    required this.url,
    this.dropdownMenuList,
    this.onOptionSelect,
    required this.bottomWidget,
  });

  @override
  State<ConsentWidget> createState() => _ConsentWidgetState();
}

class _ConsentWidgetState extends State<ConsentWidget> {
  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.dropdownMenuList!.isNotEmpty)
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: size.size12.dp,
                  ),
                  padding: EdgeInsets.only(
                    right: size.size10.dp,
                    left: size.size10.dp,
                  ),
                  child: LanguageDropdownField(
                    title: widget.dropdownMenuList!.first.title,
                    dropdownMenuList: widget.dropdownMenuList!,
                    onOptionSelect: (final DropdownMenuModel selectedOption) {
                      widget.onOptionSelect!(selectedOption);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.size20.dp),
                  child: GestureDetector(
                    onTap: widget.onCancel,
                    child: Icon(
                      Icons.close,
                      color: color.clrPrimaryPurple,
                      size: size.size24.dp,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          const SizedBox.shrink(),
        Expanded(
          flex: 3,
          child: WebView(data: widget.url),
        ),
        const Spacer(),
        Expanded(flex: 0, child: widget.bottomWidget),
      ],
    );
  }
}
