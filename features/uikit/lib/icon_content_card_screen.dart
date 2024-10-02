import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/icon/icon_content_card.dart';

class IconContentCardScreen extends StatelessWidget {
  const IconContentCardScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(left: 110, right: 110),
      child: Column(
        children: [
          IconCotentCard(
            iconPath: 'images/dmat_account_purple.svg',
            title: 'H3/16PT/Semibold',
            subTitle: 'Bodycopy 3/14PT/regular',
            package: 'uikit',
            isSelected: true,
            onSelect: (final isSelect) {
              print(isSelect);
            },
            isShowArrow: true,
          ),
          IconCotentCard(
            iconPath: 'images/dmat_account_purple.svg',
            title: 'H3/16PT/Semibold',
            package: 'uikit',
            isSelected: false,
            titleTextColor: color.greyBlackUi10,
            onSelect: (final isSelect) {},
            isShowArrow: false,
          ),
        ],
      ),
    );
  }
}
