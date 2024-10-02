import 'package:flutter/material.dart';

import '../../tcs_dff_design_system.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class FilterField extends StatefulWidget {
  final String? bankLogoPath;
  final String? package;
  final String title;
  final bool isSelected;
  final Function(bool)? onChanged;
  const FilterField({
    super.key,
    required this.title,
    required this.onChanged,
    this.bankLogoPath,
    this.package,
    this.isSelected = false,
  });

  @override
  State<FilterField> createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
  late bool _isSelected;
  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onChanged!(_isSelected);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _isSelected ? color.clrPrimaryPurple120 : color.greyWhiteUi100,
          border: _isSelected
              ? Border(
                  left: BorderSide(
                    color: color.clrPrimaryPurple,
                    width: size.size2.dp,
                  ),
                )
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.size12.dp,
            horizontal: size.size16.dp,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (widget.bankLogoPath != null)
                    Container(
                      height: size.size27.dp,
                      width: size.size27.dp,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: color.greyLightestGrey80,
                          width: size.size1.dp,
                        ),
                        shape: BoxShape.circle,
                        color: color.greyWhiteUi100,
                      ),
                      child: widget.bankLogoPath != ''
                          ? ImageWidget(
                              imageType: ImageType.assetImage,
                              path: widget.bankLogoPath!,
                              package: widget.package,
                            )
                          : null,
                    ),
                  if (widget.bankLogoPath != null)
                    SizedBox(
                      width: size.size8.dp,
                    ),
                  TextWidget(
                    text: widget.title,
                    style: textStyle.bodyCopy3Medium14SemiBold.copyWith(
                      color: _isSelected
                          ? color.clrPrimaryPurple
                          : color.greyBlackUi10,
                      fontWeight:
                          _isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
              CheckboxWidget(
                onChanged: (final val) {
                  setState(() {
                    _isSelected = val;
                  });
                },
                isChecked: _isSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
