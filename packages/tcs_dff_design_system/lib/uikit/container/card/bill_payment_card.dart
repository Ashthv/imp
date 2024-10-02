import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../image/image_widget.dart';

class BillPaymentCard extends StatefulWidget {
  final String consumerName;
  final String consumerNumber;
  final String billType;
  final String buttonText;
  final List<String> imagePath;
  final String imagePackage;
  final Color buttonBackgroundColor;
  final String payNowText;
  final Color iconBorderColor;
  final Color iconWidthColor;
  final ImageType? imageType;
  const BillPaymentCard({
    super.key,
    required this.consumerName,
    required this.consumerNumber,
    required this.billType,
    required this.buttonText,
    required this.imagePath,
    required this.imagePackage,
    required this.buttonBackgroundColor,
    required this.payNowText,
    required this.iconBorderColor,
    required this.iconWidthColor,
    this.imageType,
  });

  @override
  State<BillPaymentCard> createState() => _BillPaymentCardState();
}

class _BillPaymentCardState extends State<BillPaymentCard> {
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: ImageWidget(
            imageType: widget.imageType ?? ImageType.assetImage,
            path: widget.imagePath[0],
            package: widget.imagePackage,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: size.size16.dp,
            top: size.size6.dp,
            right: size.size20.dp,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              size.size20.dp,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.consumerName,
                        style: textStyle.h124pxsemiBold.copyWith(
                          color: color.greyFullWhite120,
                          fontWeight: FontWeight.w600,
                          fontSize: size.size16.sp,
                        ),
                      ),
                      Text(
                        widget.consumerNumber,
                        style: textStyle.h124pxsemiBold.copyWith(
                          color: color.greyFullWhite120,
                          fontWeight: FontWeight.w700,
                          fontSize: size.size14.sp,
                        ),
                      ),
                      Text(
                        widget.billType,
                        style: textStyle.h124pxsemiBold.copyWith(
                          color: color.greyFullWhite120.withOpacity(0.75),
                          fontWeight: FontWeight.w400,
                          fontSize: size.size14.sp,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: size.size46.dp,
                    height: size.size46.dp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.iconBorderColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(context.theme.appSize.size2.dp),
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.iconWidthColor,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            context.theme.appSize.size2.dp,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ImageWidget(
                              imageType:
                                  widget.imageType ?? ImageType.assetImage,
                              path: widget.imagePath[1],
                              package: widget.imagePackage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.size10.dp,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: size.size28.dp,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStatePropertyAll(size.size0.dp),
                        backgroundColor: MaterialStatePropertyAll(
                          widget.buttonBackgroundColor,
                        ),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                context.theme.appSize.size8.dp,
                              ),
                            ),
                            side: BorderSide(
                              color: widget.buttonBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        widget.buttonText,
                        style: textStyle.h124pxsemiBold.copyWith(
                          color: color.greyWhiteUi100,
                          fontSize: context.theme.appSize.size12.dp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.payNowText,
                    style: textStyle.h124pxsemiBold.copyWith(
                      fontSize: size.size16.sp,
                      fontWeight: FontWeight.w600,
                      color: color.greyFullWhite120,
                    ),
                  ),
                  ImageWidget(
                    imageType: widget.imageType ?? ImageType.assetImage,
                    path: widget.imagePath[2],
                    package: widget.imagePackage,
                    color: color.greyFullWhite120,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
