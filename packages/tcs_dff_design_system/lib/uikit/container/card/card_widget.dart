import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'card_config.dart';

class CardWidget extends StatelessWidget {
  final Widget childWidget;
  final String? childImage;
  final CardConfig cardModel;

  const CardWidget({
    super.key,
    required this.childWidget,
    this.childImage,
    required this.cardModel,
  });

  @override
  Widget build(final BuildContext context) => SizedBox(
        child: Card(
          shape: cardModel.shapeBorder,
          margin: cardModel.margin,
          elevation: cardModel.elevation,
          color: cardModel.backgroundColor,
          child: Container(
            padding: EdgeInsets.only(
              left: context.theme.appSize.size26.dp,
              right: context.theme.appSize.size16.dp,
              top: context.theme.appSize.size16.dp,
              bottom: context.theme.appSize.size16.dp,
            ),
            decoration: childImage != null
                ? BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(childImage!),
                    ),
                  )
                : const BoxDecoration(),
            child: childWidget,
          ),
        ),
      );
}
