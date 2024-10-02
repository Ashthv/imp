import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/masker/masker.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'initials_circle.dart';
import 'profile_image.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final ProfileCardType profileCardType;
  final String? infoText;
  final double? width;
  final double? height;
  final Color? borderColor;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final ImageType? imageType;
  final String? imagePath;
  final String? package;
  final String? placeholderImagePath;
  final TextAlign? textAlign;

  const ProfileCard({
    super.key,
    required this.title,
    required this.profileCardType,
    this.subtitle,
    this.infoText,
    this.width,
    this.height,
    this.borderColor,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.imageType,
    this.imagePath,
    this.package,
    this.placeholderImagePath,
    this.textAlign,
  });

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildWidgetBasedOnCase(context),
        ],
      );

  Widget defaultProfile(
    final BuildContext context,
  ) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imagePath != null && imageType != null)
          ProfileImage(
            image: imagePath!,
            package: package!,
            width: width,
            height: height,
            borderColor: borderColor,
            imageType: imageType!,
          )
        else
          InitialsCircle(
            title: title,
          ),
        SizedBox(
          height: size.size5.dp,
        ),
        Text(
          title,
          textAlign: textAlign ?? TextAlign.left,
          style: titleTextStyle ??
              textStyle.bodyCopy1Large18Bold.copyWith(
                color: color.greyBlackUi10,
                fontWeight: FontWeight.w700,
              ),
        ),
        SizedBox(
          height: size.size4.dp,
        ),
        if (subtitle != null)
          Text(
            Masker.doMask(
              originalText: subtitle!,
              maskType: MaskTypes.custom,
              customPattern: 'xxxx xxxx xxxx ####',
              maskedSymbol: 'x',
            ),
            style: subTitleTextStyle ??
                textStyle.bodyCopy3Small14Regular.copyWith(
                  color: color.greyDarkGrey30,
                ),
            textAlign: TextAlign.left,
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  Widget mobileProfile(
    final BuildContext context,
  ) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return Row(
      children: [
        if (imagePath != null && imageType != null)
          ProfileImage(
            image: imagePath!,
            package: package!,
            width: width,
            height: height,
            borderColor: borderColor,
            imageType: imageType!,
          )
        else
          InitialsCircle(
            title: title,
          ),
        SizedBox(
          width: size.size8.dp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: titleTextStyle ??
                  textStyle.bodyCopy1Large18Bold.copyWith(
                color: color.greyBlackUi10,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (subtitle != null)
              Container(
                margin: EdgeInsets.only(
                  top: size.size4.dp,
                ),
                child: Text(
                  subtitle!,
                  style: subTitleTextStyle ??
                      textStyle.bodyCopy3Small14Regular.copyWith(
                    color: color.greyDarkGrey30,
                  ),
                  textAlign: TextAlign.left,
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }

  Widget infoTextProfile(
    final BuildContext context,
  ) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return Container(
      child: Row(
        crossAxisAlignment: infoText != null
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          if (imagePath != null && imageType != null)
            ProfileImage(
              image: imagePath!,
              package: package!,
              width: width,
              height: height,
              borderColor: borderColor,
              imageType: imageType!,
            )
          else
            InitialsCircle(
              title: title,
            ),
          SizedBox(
            width: size.size8.dp,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: titleTextStyle ??
                    textStyle.labelSmall14Medium.copyWith(
                  color: color.greyBlackUi10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subtitle != null)
                Container(
                  margin: EdgeInsets.only(
                    top: size.size4.dp,
                  ),
                  child: Text(
                    subtitle!,
                    style: subTitleTextStyle ??
                        textStyle.bodyCopy3Small14Regular.copyWith(
                      color: color.greyBlackUi10,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              else
                const SizedBox.shrink(),
              if (infoText != null)
                Container(
                  margin: EdgeInsets.only(
                    top: size.size4.dp,
                  ),
                  child: Text(
                    infoText!,
                    style: textStyle.bodyCopy3Small14Regular.copyWith(
                      color: color.greyBlackUi10,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }

  Widget emailTypeProfile(
    final BuildContext context,
  ) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imagePath != null && imageType != null)
          ProfileImage(
            image: imagePath!,
            package: package!,
            width: width,
            height: height,
            borderColor: borderColor,
            imageType: imageType!,
          )
        else
          InitialsCircle(
            title: title,
          ),
        SizedBox(
          width: size.size8.dp,
        ),
        Text(
          title,
          textAlign: TextAlign.left,
          style: titleTextStyle ??
              textStyle.bodyCopy1Large18Bold.copyWith(
            color: color.greyBlackUi10,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: size.size4.dp,
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: subTitleTextStyle ??
                textStyle.bodyCopy3Small14Regular.copyWith(
              color: color.greyDarkGrey30,
            ),
            textAlign: TextAlign.left,
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  Widget accountNoTypeProfile(
    final BuildContext context,
  ) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final appTextStyle = context.theme.appTextStyles;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imagePath != null && imageType != null)
          ProfileImage(
            image: imagePath!,
            package: package!,
            width: width,
            height: height,
            borderColor: borderColor,
            placeholderImagePath: placeholderImagePath,
            imageType: imageType!,
          )
        else
          InitialsCircle(
            title: title,
          ),
        SizedBox(
          width: size.size8.dp,
        ),
        Text(
          title,
          textAlign: TextAlign.left,
          style: titleTextStyle ??
              appTextStyle.bodyCopy3Small14Regular.copyWith(
                color: color.greyDarkGrey30,
              ),
        ),
        SizedBox(
          height: size.size4.dp,
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            textAlign: TextAlign.left,
            style: titleTextStyle ??
                appTextStyle.bodyCopy1Large18Bold.copyWith(
                  color: color.greyDarkGrey30,
                ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  Widget imageTypeProfile(
    final BuildContext context,
  ) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: size.size6.dp),
              child: (imagePath != null && imageType != null)
                  ? ProfileImage(
                      image: imagePath!,
                      package: package!,
                      imageType: imageType!,
                      borderColor: color.clrPrimaryPurple100,
                    )
                  : InitialsCircle(
                      title: title,
                    ),
            ),
            Positioned(
              top: 1,
              right: 1,
              child: ImageWidget(
                imageType: ImageType.assetImage,
                path: 'assets/images/check_circle.svg',
                package: 'tcs_dff_design_system',
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.size4.dp,
        ),
        Text(
          title,
          textAlign: TextAlign.left,
          style: titleTextStyle ??
              textStyle.bodyCopy1Large18Bold.copyWith(
            color: color.greyBlackUi10,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: size.size4.dp,
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: subTitleTextStyle ??
                textStyle.bodyCopy3Small14Regular.copyWith(
              color: color.greyDarkGrey30,
            ),
            textAlign: TextAlign.left,
          ),
      ],
    );
  }

  Widget buildWidgetBasedOnCase(final BuildContext context) {
    switch (profileCardType) {
      case ProfileCardType.defaultValue:
        return defaultProfile(context);
      case ProfileCardType.mobile:
        return mobileProfile(context);
      case ProfileCardType.infoText:
        return infoTextProfile(context);
      case ProfileCardType.email:
        return emailTypeProfile(context);
      case ProfileCardType.accountNo:
        return accountNoTypeProfile(context);
      case ProfileCardType.image:
        return imageTypeProfile(context);
      default:
        return const SizedBox.shrink(); // A default case or an empty container
    }
  }
}
