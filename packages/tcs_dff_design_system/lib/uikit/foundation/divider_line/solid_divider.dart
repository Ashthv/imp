import 'package:flutter/material.dart';

class SolidDivider extends StatelessWidget {
  const SolidDivider({super.key, this.height, this.color, this.thickness});
  final double? height;
  final Color? color;
  final double? thickness;

  @override
  Widget build(final BuildContext context) => Divider(
        color: color, //color of divider
        height: height, //height spacing of divider
        thickness: thickness, //thickness of divier line
      );
}
