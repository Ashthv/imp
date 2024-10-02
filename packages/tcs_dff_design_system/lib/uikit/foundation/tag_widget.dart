import 'package:flutter/material.dart';
import '../../theme/theme.dart';

import '../../utils/sizer/app_sizer.dart';

// ignore: must_be_immutable
class TagWidget extends StatefulWidget {
  bool isSelected;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Function(bool isSelected)? onPressed;

  TagWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    this.textColor,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  State<TagWidget> createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  // bool isSelected = false;

  @override
  void initState() {
    widget.isSelected = widget.isSelected == false ? false : true;

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return ElevatedButton(
      style: ButtonStyle(
        alignment: Alignment.center,
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.size14.dp),
          ),
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.only(
            left: context.theme.appSize.size10.dp,
            right: context.theme.appSize.size10.dp,
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          widget.backgroundColor ?? context.theme.appColor.clrPrimaryPurple10,
        ),
      ),
      onPressed: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
        if (widget.onPressed != null) {
          widget.onPressed!(widget.isSelected);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.isSelected)
            Icon(
              opticalSize: context.theme.appSize.size16.dp,
              Icons.check,
              color:
                  widget.textColor ?? context.theme.appColor.greyFullWhite120,
            )
          else
            Container(),
          Padding(
            padding: EdgeInsets.only(left: context.theme.appSize.size6.dp),
          ),
          Text(
            widget.text,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: context.theme.appSize.size14.dp,
                  color: widget.textColor ??
                      context.theme.appColor.greyFullWhite120,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Padding(
            padding: EdgeInsets.only(left: context.theme.appSize.size6.dp),
          ),
        ],
      ),
    );
  }
}
