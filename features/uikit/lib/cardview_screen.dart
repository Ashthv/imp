import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/card/card_config.dart';
import 'package:tcs_dff_design_system/uikit/container/card/card_widget.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class CardViewScreen extends StatefulWidget {
  const CardViewScreen({super.key});

  @override
  State<CardViewScreen> createState() => _CardViewScreenState();
}

class _CardViewScreenState extends State<CardViewScreen> {
  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.theme.appSize.size8),
        child: Column(
          children: [
            CardWidget(
              cardModel: CardConfig(
                backgroundColor: context.theme.appColor.clrPrimaryPurple,
                height: context.theme.appSize.size200,
                width: context.theme.appSize.size200,
                elevation: context.theme.appSize.size5,
                margin: EdgeInsets.all(context.theme.appSize.size10),
                shapeBorder: RoundedRectangleBorder(
                  side: BorderSide(
                    color: context.theme.appColor.greyLightestGrey80,
                    width: context.theme.appSize.size2,
                  ),
                  borderRadius: BorderRadius.circular(
                    context.theme.appSize.size18,
                  ),
                ),
              ),
              childImage: 'images/add.png',
              childWidget: Column(
                children: [
                  Text(
                    locale.txt(key: 'comingSoonText'),
                    style: TextStyle(
                      color: context.theme.appColor.greyFullWhite120,
                    ),
                  ),
                  Text(
                    locale.txt(key: 'comingSoonText'),
                    style: TextStyle(
                      color: context.theme.appColor.greyFullWhite120,
                    ),
                  ),
                  Text(
                    locale.txt(key: 'comingSoonText'),
                    style: TextStyle(
                      color: context.theme.appColor.greyFullWhite120,
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
