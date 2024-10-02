import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';

class NoteWidget extends StatelessWidget {
  final NoteVariants variant;
  final String heading;
  final TextStyle? headingStyle;
  final String description;
  final TextStyle? descriptionStyle;
  final List<String>? styledTextList;
  final TextStyle? highlightTextStyle;
  final Map<String, VoidCallback> hyperLinkMap;
  final TextStyle? hyperLinkTextStyle;
  const NoteWidget({
    super.key,
    required this.variant,
    required this.heading,
    required this.description,
    this.styledTextList,
    this.hyperLinkMap = const {},
    this.headingStyle,
    this.descriptionStyle,
    this.hyperLinkTextStyle,
    this.highlightTextStyle,
  });

  @override
  Widget build(final BuildContext context) => Container(
        width: double.infinity,
        padding: variant.getPadding(context),
        decoration: BoxDecoration(
          color: variant.getBgColor(context),
          borderRadius: BorderRadius.all(
            Radius.circular(variant.getBorderRadius(context)),
          ),
        ),
        child: getLayout(context),
      );

  Widget getLayout(final BuildContext context) {
    if (variant == NoteVariants.note) {
      return Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child:
                getRichText(context: context, text: '', headingText: heading),
          ),
          getRichText(
            context: context,
            text: description,
          ),
        ],
      );
    } else if (variant == NoteVariants.infoNote) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(
              path: variant.getImagePath(context)!,
             package: 'tcs_dff_design_system',
             imageType: ImageType.assetImage,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: context.theme.appSize.size8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.clip,
                    description,
                    style: variant.getDescriptionStyle(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (variant == NoteVariants.errorInfoNote) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ImageWidget(
              imageType: ImageType.assetImage,
              path: variant.getImagePath(context)!,
              package: 'tcs_dff_design_system',
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: context.theme.appSize.size10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: getRichText(
                    context: context,
                    text: '',
                    headingText: heading,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (variant == NoteVariants.warningInfoNote) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ImageWidget(
              imageType: ImageType.assetImage,
              path: variant.getImagePath(context)!,
              package: 'tcs_dff_design_system',
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: context.theme.appSize.size10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: getRichText(
                    context: context,
                    text: '',
                    headingText: heading,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return getRichText(
        context: context,
        headingText: heading,
        text: description,
      );
    }
  }

  // below logic is reused and tinkered from TextWidget
  RichText getRichText({
    required final BuildContext context,
    required final String text,
    final String headingText = '',
  }) =>
      RichText(
        text: getStyledText(
          context: context,
          text: text,
          headingText: headingText,
          styledTextList: styledTextList ?? [],
        ),
      );

  TextSpan getStyledText({
    required final BuildContext context,
    required final String text,
    required final String headingText,
    required final List<String> styledTextList,
  }) {
    final textSpans = <InlineSpan>[];
    final splitTextList =
        splitTextUsingStyledTextList(context, text, styledTextList);

    //heading textspan
    textSpans.add(
      TextSpan(
        text: headingText,
        style: headingStyle ?? variant.getHeadingStyle(context),
      ),
    );

    // description textspan
    for (final splitText in splitTextList) {
      if (styledTextList.contains(splitText) &&
          !hyperLinkMap.keys.toList().contains(splitText)) {
        // adding textspan for Highlight text
        textSpans.add(
          TextSpan(
            text: splitText,
            style: highlightTextStyle ?? variant.getHighlightStyle(context),
          ),
        );
      } else if (hyperLinkMap.keys.toList().contains(splitText)) {
        // adding textspan for HyperLink text
        textSpans.add(
          TextSpan(
            text: splitText,
            style: hyperLinkTextStyle ?? variant.getHyperLinkStyle(context),
            recognizer: TapGestureRecognizer()
              ..onTap = hyperLinkMap[splitText] ?? () {},
          ),
        );
      } else {
        // adding textspan for normal description text
        textSpans.add(
          TextSpan(
            text: splitText,
            style: descriptionStyle ?? variant.getDescriptionStyle(context),
          ),
        );
      }
    }

    return TextSpan(
      children: textSpans,
    );
  }

  List<String> splitTextUsingStyledTextList(
    final BuildContext context,
    final String text,
    final List<String> styledTextList,
  ) {
    final splitTextList = <String>[];
    var currentIndex = 0;
    final styleTextListWithLinks = styledTextList;

    hyperLinkMap.keys.forEach(styleTextListWithLinks.add);

    for (final styledText in styledTextList) {
      final index = text.indexOf(styledText, currentIndex);

      if (index != -1) {
        splitTextList
          ..add(text.substring(currentIndex, index))
          ..add(styledText);
        currentIndex = index + styledText.length;
      }
    }

    if (currentIndex < text.length) {
      splitTextList.add(text.substring(currentIndex));
    }

    return splitTextList;
  }
}
