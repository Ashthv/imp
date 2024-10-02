import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../theme/theme_extensions/color_extension.dart';
import '../../../theme/theme_extensions/size_extension.dart';
import '../../../utils/bottomsheet_template_model.dart';
import '../../../utils/button_utils.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/button/borderlined_button.dart';
import '../../foundation/button/normal_button.dart';
import '../../foundation/text_widget.dart';

class BottomsheetTemplate extends StatelessWidget {
  final BottomsheetTemplateData bottomsheetTemplateData;
  BottomsheetTemplate({super.key, required this.bottomsheetTemplateData});

  @override
  Widget build(final BuildContext context) {
    final isTitleTextVisible =
        bottomsheetTemplateData.titleText == null ? false : true;
    final isButtonContainerVisible =
        bottomsheetTemplateData.primaryButtonText != null ||
            bottomsheetTemplateData.secondaryButtonText != null;
    final isPrimaryButtonVisible =
        bottomsheetTemplateData.primaryButtonText != null;
    final isSecondaryButtonVisible =
        bottomsheetTemplateData.secondaryButtonText != null;
    return Container(
      color: bottomsheetTemplateData.backgroundColor ??
          context.theme.appColor.greyFullWhite120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _titleContent(
            context,
            isTitleTextVisible,
          ),
          Visibility(
            visible: isTitleTextVisible,
            maintainAnimation: isTitleTextVisible,
            maintainSize: isTitleTextVisible,
            maintainState: isTitleTextVisible,
            child: SizedBox(
              height: context.theme.appSize.size12.dp,
            ),
          ),
          bottomsheetTemplateData.content,
          _buttonContainer(
            context,
            isButtonContainerVisible,
            isSecondaryButtonVisible,
            isPrimaryButtonVisible,
          ),
        ],
      ),
    );
  }

  Widget _titleContent(
    final BuildContext context,
    final bool isTitleTextVisible,
  ) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: getBannerWidget(size, color, context),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: isTitleTextVisible
                    ? Container(
                        margin: EdgeInsets.fromLTRB(
                          size.size21.dp,
                          size.size21.dp,
                          0.0,
                          0.0,
                        ),
                        alignment: Alignment.centerLeft,
                        child: TextWidget(
                          text: bottomsheetTemplateData.titleText ?? '',
                          style: textStyle.h124pxsemiBold.copyWith(
                            color: color.clrPrimaryPurple,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              if (bottomsheetTemplateData.onCloseButtonTap != null)
                Container(
                  margin: EdgeInsets.fromLTRB(
                    size.size8.dp,
                    size.size21.dp,
                    size.size21.dp,
                    0.0,
                  ),
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed:
                        bottomsheetTemplateData.onCloseButtonTap ?? () {},
                    icon: Icon(Icons.close, color: color.clrPrimaryPurple),
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }

  Widget getBannerWidget(
    final AppSizeExtension size,
    final AppColorsExtension color,
    final BuildContext context,
  ) {
    if (bottomsheetTemplateData.bannerText != null &&
        bottomsheetTemplateData.bannerText!.isNotEmpty) {
      return Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: size.size15.dp,
        ),
        decoration: BoxDecoration(
          color: color.clrPrimaryPurple,
        ),
        child: TextWidget(
          text: bottomsheetTemplateData.bannerText!,
          style: context.theme.appTextStyles.h414pxRegular.copyWith(
            color: color.greyWhiteUi100,
            fontSize: size.size16.dp,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buttonContainer(
    final BuildContext context,
    final bool isButtonContainerVisible,
    final bool isSecondaryButtonVisible,
    final bool isPrimaryButtonVisible,
  ) {
    final size = context.theme.appSize;
    return Visibility(
      visible: isButtonContainerVisible,
      child: Container(
        margin: EdgeInsets.all(size.size21.dp),
        child: Column(
          children: <Widget>[
            Visibility(
              visible: isSecondaryButtonVisible,
              child: Row(
                children: [
                  Expanded(
                    child: BorderlinedButton(
                      caption:
                          bottomsheetTemplateData.secondaryButtonText ?? '',
                      onPressed:
                          bottomsheetTemplateData.onSecondaryButtonTap ?? () {},
                      buttonType: ButtonVariants.fourColumn,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isPrimaryButtonVisible,
              child: SizedBox(
                height: size.size20.dp,
              ),
            ),
            Visibility(
              visible: isPrimaryButtonVisible,
              child: Row(
                children: [
                  Expanded(
                    child: NormalButton(
                      caption: bottomsheetTemplateData.primaryButtonText ?? '',
                      onPressed:
                          bottomsheetTemplateData.onPrimaryButtonTap ?? () {},
                      buttonType: ButtonVariants.fourColumn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
