import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/menu_item_model.dart';
import '../../foundation/toggle.dart';

class KebabMenuWidget extends StatelessWidget {
  KebabMenuWidget({
    super.key,
    this.icon,
    required this.list,
    required this.onPressed,
    this.onTap,
  });

  final Widget? icon;
  final List<MenuItemModel> list;
  final Function(int) onPressed;
  final Function(bool)? onTap;

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return MenuAnchor(
      builder: (
        final BuildContext context,
        final MenuController controller,
        final Widget? child,
      ) =>
          InkWell(
        onTap: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: icon,
      ),
      style: MenuStyle(
        surfaceTintColor: MaterialStatePropertyAll<Color>(color.greyWhiteUi100),
        side: MaterialStatePropertyAll<BorderSide>(
          BorderSide(color: color.greyOffWhite90),
        ),
        shadowColor: MaterialStatePropertyAll<Color>(color.clrPrimaryPurple20),
      ),
      menuChildren: List<MenuItemButton>.generate(
        list.length,
        (final int index) => MenuItemButton(
          onPressed: () => onPressed(index),
          trailingIcon: getToggleButton(index),
          child: Text(
            list[index].lable,
            style: textStyle.labelSmall16Medium.copyWith(
              color: color.greyDarkestGrey20,
            ),
          ),
        ),
      ),
    );
  }

  Widget getToggleButton(final int index) {
    if (list[index].isToggleButtonShow == true) {
      return Toggle(
        defaultState: list[index].isToggleActive ?? false,
        onTap: onTap,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
