import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../../utils/snackbar_utils.dart';
import '../button/hyperlink_button.dart';
import '../button/tertiary_button.dart';

class SnackBarWidget extends StatefulWidget {
  final SnackbarType snackbarType;
  final String message;

  final bool isDissmiss;
  final bool? isAction;
  final String? actionCaption;
  final Function()? onActionTap;
  final Axis contentAxis;

  final Duration? progressDuration;

  const SnackBarWidget({
    super.key,
    required this.snackbarType,
    required this.message,
    this.isDissmiss = false,
    this.isAction = false,
    this.actionCaption,
    this.onActionTap,
    this.contentAxis = Axis.horizontal,
    this.progressDuration,
  });

  @override
  State<SnackBarWidget> createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<SnackBarWidget> {
  double _progressValue = 0.0;

  @override
  void initState() {
    if (widget.progressDuration != null) initIndicatorProgress();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final size = context.theme.appSize;
    return Container(
      decoration: BoxDecoration(
        color: widget.snackbarType.getBackgroundColor(context),
        borderRadius: BorderRadius.circular(context.theme.appSize.size6.dp),
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(context.theme.appSize.size8.dp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.snackbarType.getIcon(context),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: context.theme.appSize.size8.dp,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      overflow: TextOverflow.clip,
                                      widget.message,
                                      style: context.theme.appTextStyles
                                          .bodyCopy3Small14Regular
                                          .copyWith(
                                        height: 1.5,
                                        color: widget.snackbarType
                                            .getTextColor(context),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      widget.contentAxis == Axis.horizontal,
                                  child: (widget.isAction == true)
                                      ? TertiaryButton(
                                          caption: widget.actionCaption ?? '',
                                          isEnabled: false,
                                          textFontSize: size.size14.dp,
                                          buttonColor: context
                                              .theme.appColor.greyDarkGrey30,
                                          onPressed:
                                              widget.onActionTap ?? () {},
                                        )
                                      : InkWell(
                                          onTap: () =>
                                              ScaffoldMessenger.of(context)
                                                  .removeCurrentSnackBar(),
                                          child: Icon(
                                            Icons.close,
                                            size:
                                                context.theme.appSize.size24.dp,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: widget.contentAxis == Axis.vertical &&
                                  widget.isDissmiss,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: context.theme.appSize.size10.dp,
                                ),
                                child: HyperlinkButton(
                                  caption:
                                      locale.txt(key: 'snackBarDismissLabel'),
                                  labelFontSize: size.size14.dp,
                                  linkColor:
                                      widget.snackbarType.getTextColor(context),
                                  onPressedLinkColor:
                                      widget.snackbarType.getTextColor(context),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentSnackBar();
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: widget.contentAxis == Axis.vertical &&
                                  widget.isAction == true,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: context.theme.appSize.size10.dp,
                                ),
                                child: TertiaryButton(
                                  caption: widget.actionCaption ?? '',
                                  isEnabled: false,
                                  textFontSize: size.size14.dp,
                                  buttonColor:
                                      context.theme.appColor.greyDarkGrey30,
                                  onPressed: widget.onActionTap ?? () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.progressDuration != null)
              LinearProgressIndicator(
                color: widget.snackbarType.getProgressBarColor(context),
                value: _progressValue,
                backgroundColor:
                    widget.snackbarType.getBackgroundColor(context),
              ),
          ],
        ),
      ),
    );
  }

  void initIndicatorProgress() {
    final progressDurationInSec = widget.progressDuration!.inMilliseconds;
    const timerDuration = Duration(milliseconds: 50);

    Timer.periodic(timerDuration, (final timer) {
      _progressValue = 1 *
          (timerDuration.inMilliseconds / progressDurationInSec) *
          timer.tick;
      setState(() {});

      if (_progressValue >= 1.0) timer.cancel();
    });
  }
}
