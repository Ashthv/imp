import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../theme/theme_extensions/size_extension.dart';
import '../../utils/image_type.dart';
import '../../utils/sizer/app_sizer.dart';
import 'image/image_widget.dart';

class TermsConditionWidget extends StatelessWidget {
  final String titleText;
  final String descriptionText;
  final String acceptButtonText;
  final List<String> dropDownList;
  final void Function() onAcceptButtonTap;
  final void Function() onCloseButtonTap;
  final Function(String selectedOption) onOptionSelect;

  final ScrollController _scrollableController = ScrollController();

  TermsConditionWidget({
    super.key,
    required this.titleText,
    required this.descriptionText,
    required this.acceptButtonText,
    required this.dropDownList,
    required this.onAcceptButtonTap,
    required this.onCloseButtonTap,
    required this.onOptionSelect,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Container(
      padding: EdgeInsets.only(top: size.size10.dp),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: size.size3.toInt(),
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
                  width: size.size90.dp,
                  // child: DropDownWidgetUnderLine(
                  //   optionList: dropDownList,
                  //   onOptionSelect: onOptionSelect,
                  // ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: size.size3.toInt(),
            child: _titleView(context, size),
          ),
          Flexible(
            flex: size.size5.toInt(),
            child: _scrollableTextView(context, size),
          ),
        ],
      ),
    );
  }

  Container _titleView(
    final BuildContext context,
    final AppSizeExtension size,
  ) =>
      Container(
        margin: EdgeInsets.only(
          left: size.size22.dp,
          right: size.size22.dp,
          top: size.size12.dp,
          bottom: size.size12.dp,
        ),
        child: Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: titleText,
                    style:
                        context.theme.appTextStyles.labelSmall14Medium.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: size.size24.dp,
                      color: context.theme.appColor.clrPrimaryPurple,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.size8.dp,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: size.size40.dp,
                height: size.size40.dp,
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: 'assets/images/volume.png',
                  package: 'tcs_dff_design_system',
                ),
              ),
            ),
          ],
        ),
      );

  Container _scrollableTextView(
    final BuildContext context,
    final AppSizeExtension size,
  ) =>
      Container(
        margin: EdgeInsets.only(
          left: size.size22.dp,
          right: size.size22.dp,
          top: size.size12.dp,
          bottom: size.size12.dp,
        ),
        child: Scrollbar(
          controller: _scrollableController,
          child: ListView.builder(
            controller: _scrollableController,
            shrinkWrap: true,
            itemCount: size.size1.toInt(),
            itemBuilder: (final BuildContext context, final int index) => Text(
              descriptionText,
              style: context.theme.appTextStyles.labelSmall14Medium.copyWith(
                fontSize: size.size14.dp,
                color: context.theme.appColor.greyDarkestGrey20,
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
            ),
          ),
        ),
      );
}
