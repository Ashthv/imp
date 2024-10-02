import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/card/card_config.dart';
import 'package:tcs_dff_design_system/uikit/container/t_and_c_share_download_mail_widget.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class TAndCShareDownloadMailScreen extends StatelessWidget {
  const TAndCShareDownloadMailScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.theme.appSize.size8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TAndCShareDownloadMailWidget(
              cardModel: CardConfig(
                backgroundColor: context.theme.appColor.greyWhiteUi100,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    context.theme.appSize.size8,
                  ),
                ),
              ),
              imagePackage: 'uikit',
              fileimagePath: 'images/file_img.svg',
              infoImagePath: 'images/info.png',
              title: locale.txt(key: 'termsConditionsTitle'),
              subTitle: locale.txt(key: 'termsConditionsSubTitle'),
              infoButtonAction: () {},
              viewImagePath: 'images/visibility.svg',
              downloadIcon: 'images/download.svg',
              emailIcon: 'images/mail.svg',
              viewButtonAction: () {},
              downloadButtonAction: () {},
              emailButtonAction: () {},
            ),
          ],
        ),
      ),
    );
  }
}
