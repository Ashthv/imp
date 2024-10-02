import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_route/route_navigator.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Bottomsheet Template',
  type: BottomsheetTemplate,
)
Widget primaryNormalButtonUseCase(final BuildContext context) => Row(
      children: [
        Expanded(
          child: NormalButton(
            buttonType: ButtonVariants.normal,
            caption: 'Bottomsheet default template',
            onPressed: () {
              showBottomSheetModal(
                context,
                BottomsheetTemplate(
                  bottomsheetTemplateData: BottomsheetTemplateData(
                    content: const TextWidget(text: 'subtitle'),
                    primaryButtonText: 'verify',
                    secondaryButtonText: 'close',
                    onPrimaryButtonTap: () {},
                    onSecondaryButtonTap: () {},
                    onCloseButtonTap: () {
                      RouteNavigator.pop(context);
                    },
                    //  bannerText: 'you are send Rs 5000',
                    titleText: 'This is sample OTP Screen title',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
