import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/size.dart';
import '../../theme/theme.dart';
import '../../theme/theme_extensions/color_extension.dart';
import '../../theme/theme_extensions/size_extension.dart';
import '../../utils/sizer/app_sizer.dart';

class MPin extends StatefulWidget {
  final int mpinLength;
  final bool isValidMpin;
  final ValueChanged<String> mpinCallBack;
  final bool isDense;
  final bool isOutLineBorder;
  final EdgeInsetsGeometry? contentPadding;

  final List<TextEditingController>? mpinInputController;
  final bool obscureText;
  final String obscuringCharacter;
  final MpinStyle? mpinStyle;
  final bool isMpin;

  MPin({
    super.key,
    required this.mpinLength,
    this.isValidMpin = true,
    this.isOutLineBorder = false,
    this.contentPadding = EdgeInsets.zero,
    required this.mpinCallBack,
    this.mpinInputController,
    this.obscureText = true,
    this.obscuringCharacter = '*',
    this.mpinStyle,
    this.isDense = false,
    this.isMpin = false,
  });

  @override
  State<MPin> createState() => _MPinState();
}

class _MPinState extends State<MPin> {
  final List<FocusNode> _focusNodes = [];
  final List<String> _values = [];
  @override
  void dispose() {
    widget.mpinInputController!
        .removeRange(0, widget.mpinInputController!.length - 1);
    _focusNodes.removeRange(0, _focusNodes.length - 1);
    _values.removeRange(0, _values.length - 1);
    super.dispose();
  }

  @override
  void initState() {
    for (var i = 0; i < widget.mpinLength; i++) {
      widget.mpinInputController!.add(TextEditingController());
      _values.add('');
      _focusNodes.add(
        FocusNode(
          debugLabel: '$i',
          onKeyEvent: _handleKeyEvent,
        ),
      );
    }
    setState(() {});
    super.initState();
  }

  KeyEventResult _handleKeyEvent(final FocusNode node, final KeyEvent event) {
    if (event is KeyUpEvent) return KeyEventResult.ignored;

    final focusIndex = _focusNodes.indexWhere(
      (final element) => element.debugLabel == node.debugLabel,
    );

    final currentText = widget.mpinInputController![focusIndex].text;

    /// When backspace pressed and current field is empty then
    /// clear previous field and put focus directly to
    /// previous to previous field
    if (event.logicalKey == LogicalKeyboardKey.backspace &&
        currentText.isEmpty) {
      node.previousFocus();
      widget.mpinInputController![focusIndex - 1].text = '';
      _values[focusIndex - 1] = '';
      node.previousFocus();
    }

    /// When backspace pressed and current field is not empty then
    /// clear current field and put focus directly to previous field
    if (event.logicalKey == LogicalKeyboardKey.backspace &&
        currentText.isNotEmpty) {
      widget.mpinInputController![focusIndex].text = '';
      _values[focusIndex] = '';
      node.previousFocus();
    }

    /// When key pressed is digit and focus is less than total inputs then
    /// apply delay to show input before obscuring incase of otp and
    /// incase of mpin no delay obscure directly
    if (_isLogicalKeyDigit(event) &&
        focusIndex < widget.mpinInputController!.length) {
      widget.mpinInputController![focusIndex].text = event.character!;
      _values[focusIndex] = event.character!;

      Future.delayed(
          Duration(
            milliseconds: widget.isMpin || !widget.obscureText ? 0 : 120,
          ), () {
        _maskUnmaskInputs();
        node.nextFocus();
      });
    }

    widget.mpinCallBack(_values.join());

    return KeyEventResult.handled;
  }

  bool _isLogicalKeyDigit(final KeyEvent event) {
    switch (event.logicalKey) {
      case LogicalKeyboardKey.digit0:
      case LogicalKeyboardKey.digit1:
      case LogicalKeyboardKey.digit2:
      case LogicalKeyboardKey.digit3:
      case LogicalKeyboardKey.digit4:
      case LogicalKeyboardKey.digit5:
      case LogicalKeyboardKey.digit6:
      case LogicalKeyboardKey.digit7:
      case LogicalKeyboardKey.digit8:
      case LogicalKeyboardKey.digit9:
        return true;
      default:
        return false;
    }
  }

  void _maskUnmaskInputs() {
    for (var index = 0; index < widget.mpinInputController!.length; index++) {
      /// Skip setting mask and unmask value when field is empty
      if (widget.mpinInputController![index].text.isEmpty &&
          _values[index].isEmpty) continue;

      widget.mpinInputController![index].text =
          widget.obscureText ? widget.obscuringCharacter : _values[index];
    }
  }

  Widget pinInputBox(
    final TextEditingController controller,
    final AppSizeExtension size,
    final AppColorsExtension appColor,
    final FocusNode focusNode,
  ) =>
      Expanded(
        child: Container(
          child: TextField(
            cursorHeight: 0,
            enableSuggestions: false,
            enableInteractiveSelection: false,
            focusNode: focusNode,
            style: context.theme.appTextStyles.h520pxMedium.copyWith(
              color: widget.mpinStyle != null &&
                      widget.mpinStyle!.textColor != null
                  ? widget.mpinStyle!.textColor
                  : appColor.clrPrimaryPurple,
              fontSize:
                  widget.mpinStyle != null && widget.mpinStyle!.textSize != null
                      ? widget.mpinStyle!.textSize?.dp
                      : AppSizes.size16.dp,
              fontWeight: FontWeight.w500,
            ),
            autocorrect: false,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: controller,
            maxLength: 1,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(size.size2.dp),
              isDense: widget.isDense,
              border: widget.isOutLineBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.size6),
                      borderSide: BorderSide(
                        width: size.size2.dp,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(size.size6),
                      borderSide: BorderSide(
                        width: size.size2.dp,
                      ),
                    ),
              focusedBorder: widget.isOutLineBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.mpinStyle != null &&
                                widget.mpinStyle!.focusedBorderColor != null
                            ? widget.mpinStyle!.focusedBorderColor!
                            : widget.mpinStyle != null &&
                                    widget.mpinStyle!.textColor != null
                                ? widget.mpinStyle!.textColor!
                                : appColor.clrPrimaryPurple,
                        width: size.size3.dp,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.mpinStyle != null &&
                                widget.mpinStyle!.focusedBorderColor != null
                            ? widget.mpinStyle!.focusedBorderColor!
                            : widget.mpinStyle != null &&
                                    widget.mpinStyle!.textColor != null
                                ? widget.mpinStyle!.textColor!
                                : appColor.clrPrimaryPurple,
                        width: size.size3.dp,
                      ),
                    ),
              enabledBorder: widget.isOutLineBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.mpinStyle != null &&
                                widget.mpinStyle!.borderColor != null
                            ? widget.mpinStyle!.borderColor!
                            : controller.text == ''
                                ? appColor.greyLighterGrey70
                                : widget.isValidMpin
                                    ? appColor.clrPrimaryPurple
                                    : appColor.statRedDefault,
                        width: size.size3.dp,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.mpinStyle != null &&
                                widget.mpinStyle!.borderColor != null
                            ? widget.mpinStyle!.borderColor!
                            : controller.text == ''
                                ? appColor.greyLighterGrey70
                                : widget.isValidMpin
                                    ? appColor.clrPrimaryPurple
                                    : appColor.statRedDefault,
                        width: size.size3.dp,
                      ),
                    ),
              counterText: '',
              fillColor: widget.mpinStyle != null &&
                      widget.mpinStyle!.fillColor != null
                  ? widget.mpinStyle!.fillColor
                  : appColor.transparent,
              filled: true,
            ),
            cursorColor: widget.mpinStyle?.cursorColor,
          ),
        ),
      );

  @override
  void didUpdateWidget(covariant final MPin oldWidget) {
    if (widget.obscureText != oldWidget.obscureText) {
      _maskUnmaskInputs();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.mpinLength > 0)
                ...List.generate(
                  widget.mpinLength * 2 - 1,
                  (final index) => index,
                )
                    .map(
                      (final e) => e.remainder(2) == 0
                          ? pinInputBox(
                              widget.mpinInputController![e ~/ 2],
                              context.theme.appSize,
                              context.theme.appColor,
                              _focusNodes[e ~/ 2],
                            )
                          : SizedBox(
                              width: context.theme.appSize.size8.dp,
                            ),
                    )
                    .toList(),
            ],
          ),
          SizedBox(
            height: context.theme.appSize.size7.dp,
          ),
        ],
      );
}

class MpinStyle {
  Color? borderColor;
  Color? fillColor;
  Color? textColor;
  Color? focusedBorderColor;
  double? textSize;
  Color? cursorColor;

  MpinStyle({
    this.borderColor,
    this.fillColor,
    this.textColor,
    this.focusedBorderColor,
    this.textSize,
    this.cursorColor,
  });
}
