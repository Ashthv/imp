import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class ButtonItem {
  String text;
  bool selected;
  bool disabled;

  ButtonItem(this.text, this.selected, this.disabled);
}

class TimeSlot extends StatefulWidget {
  final List<ButtonItem> buttons;
  final Function(String) onButtonSelected;
  final String textSlot;
  const TimeSlot({
    super.key,
    required this.buttons,
    required this.onButtonSelected,
    required this.textSlot,
  });

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  String selectedText = ' ';
  void selectButton(final int index) {
    if (!widget.buttons[index].disabled) {
      setState(() {
        for (var i = 0; i < widget.buttons.length; i++) {
          widget.buttons[i].selected = (i == index);
        }
        selectedText = widget.buttons[index].text;
        widget.onButtonSelected(widget.buttons[index].text);
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        spacing: context.theme.appSize.size20.dp,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: context.theme.appSize.size8.dp,
              bottom: context.theme.appSize.size8.dp,
            ),
            child: Text(
              widget.textSlot,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.theme.appColor.greyFullBlack10,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.theme.appSize.size3.dp.toInt(),
              childAspectRatio: context.theme.appSize.size2.dp,
            ),
            itemCount: widget.buttons.length,
            itemBuilder: (final context, final index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: context.theme.appSize.size8.dp,
                vertical: context.theme.appSize.size8.dp,
              ),
              child: widget.buttons[index].disabled
                  ? OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(context.theme.appSize.size0.dp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            context.theme.appSize.size8.dp,
                          ),
                          side: BorderSide(
                            color: context.theme.appColor.greyLightestGrey80,
                          ),
                        ),
                      ),
                      child: Text(
                        widget.buttons[index].text,
                        style: TextStyle(
                          fontSize: size.size16.sp,
                          color: context.theme.appColor.greyDarkestGrey20,
                        ),
                      ),
                    )
                  : widget.buttons[index].selected
                      ? ElevatedButton(
                          onPressed: () => selectButton(index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                context.theme.appColor.greyDarkestGrey20,
                            padding: EdgeInsets.all(
                              context.theme.appSize.size0.dp,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.theme.appSize.size8.dp,
                              ),
                            ),
                          ),
                          child: Text(
                            widget.buttons[index].text,
                            style: TextStyle(
                              fontSize: context.theme.appSize.size18.dp,
                              color: context.theme.appColor.greyFullWhite120,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: () => selectButton(index),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(
                              context.theme.appSize.size0.dp,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.theme.appSize.size8.dp,
                              ),
                            ),
                          ),
                          child: Text(
                            widget.buttons[index].text,
                            style: TextStyle(
                              fontSize: context.theme.appSize.size18.dp,
                              color: context.theme.appColor.greyFullBlack10,
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
