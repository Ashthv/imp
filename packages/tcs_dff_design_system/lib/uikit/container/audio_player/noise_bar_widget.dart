import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class NoiceBarWidget extends StatefulWidget {
  final List<double> barHeightList;

  const NoiceBarWidget({
    super.key,
    required this.barHeightList,
  });

  @override
  State<NoiceBarWidget> createState() => _NoiceBarWidgetState();
}

class _NoiceBarWidgetState extends State<NoiceBarWidget> {
  @override
  Widget build(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: widget.barHeightList
            .map((final e) => getSingleNoiceBar(context, e))
            .toList(),
      );

  Container getSingleNoiceBar(
    final BuildContext context,
    final double height,
  ) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: .2.w),
      width: .58.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.size1.dp),
        color: color.greyDarkGrey30,
      ),
    );
  }
}
