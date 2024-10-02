import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class CountryCodeWideget extends StatelessWidget {
  final String countryCode;
  const CountryCodeWideget({
    super.key,
    required this.countryCode,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            countryCode,
            style: textStyle.bodyCopy1Medium18Medium.copyWith(
              fontSize: size.size18.sp,
              color: color.greyBlackUi10,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            width: size.size4.dp,
          ),
          Text(
            '|',
            style: textStyle.bodyCopy1Medium18Medium
                .copyWith(fontSize: size.size18.sp, color: color.greyBlackUi10),
          ),
          SizedBox(
            width: size.size4.dp,
          ),
        ],
      ),
    );
  }
}
