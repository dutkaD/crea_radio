library crea_radio_button;

import 'package:flutter/material.dart';

/// [RadioOption] - an option passed to the [RadioButtonGroup]
class RadioOption<T> {
  /// an actual value of the option
  final T value;

  /// label of the option -> is rendered on the radio button
  final String label;

  RadioOption(this.value, this.label);
}

// class RadioValue<T> {
//   const RadioValue({
//     required this.value,
//   });
//   /// The value represented by this radio button.
//   final T value;
// }

/// Group of radio buttons, where only one option can be selected
/// Requires list of [options] and [callback] function
class RadioButtonGroup extends StatefulWidget {
  /// List of options for the group
  final List<RadioOption> options;

  /// Callback function
  final Function callback;

  /// How many rows or columns should be options devided into
  /// Default: 1. Options are places in a single column or row
  /// Should be > 0
  final int multilineNumber;

  /// Color which is used when the button is active (selected)
  final Color? selectedColor;

  /// Button text style
  final TextStyle? textStyle;

  /// Color which is used when the button is NOT selected
  final Color mainColor;

  /// Main Axis Alignment of the buttons. Default [MainAxisAlignment.spaceAround]
  final MainAxisAlignment? mainAxisAlignment;

  /// Cross Axis Alignment of the buttons. Default [CrossAxisAlignment.center]
  final CrossAxisAlignment? crossAxisAlignment;

  /// Direction of the [RadioButtonGroup].
  /// Default: vertical = false -> horizontal display
  /// Set vertical to true to display options as a column
  final bool vertical;

  /// Height of the option button in the group
  final double buttonHeight;

  /// Width of the option button in the group
  final double buttonWidth;

  /// Width between columns or rows of radio options
  final double betweenMultiLines;

  /// Space between buttons
  /// Default value:  8.0
  /// If [vertical] = true -> adds space vertically
  /// If [vertical] = false -> adds space horizontally
  final double spaceBetween;

  /// Index of the [RadioOption] in [options] that is selected by default
  final int? preSelectedIdx;

  /// Shape of the button
  /// Default [circular] = false -> Rectangular shape
  /// Set to true to have round buttons
  final bool circular;

  /// When pressing the selected button, the value of the group will be set to null
  /// Default: false
  final bool unselectEnabled;

  /// Defines the border for the selected button.
  /// Transparent and 0 with by default.
  final BorderSide? selectedBorderSide;

  const RadioButtonGroup(
      {Key? key,
      required this.options,
      required this.callback,
      this.selectedColor,
      this.mainColor = Colors.grey,
      this.vertical = false,
      this.buttonHeight = 50,
      this.buttonWidth = 50,
      this.circular = false,
      this.spaceBetween = 8.0,
      this.preSelectedIdx,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.textStyle,
      this.selectedBorderSide,
      this.multilineNumber = 1,
      this.betweenMultiLines = 0,
      this.unselectEnabled = false})
      : super(key: key);

  @override
  State<RadioButtonGroup> createState() => _RadioButtonGroupState();

  RadioButtonGroup copyWith(
      {List<RadioOption>? options,
      Function? callback,
      Color? selectedColor,
      Color? mainColor,
      bool? vertical,
      double? buttonHeight,
      double? buttonWidth,
      double? spaceBetween,
      double? betweenMultiLines,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      TextStyle? textStyle,
      int? preSelectedIdx,
      bool? circular,
      BorderSide? borderSide,
      bool? allowUnSelect}) {
    return RadioButtonGroup(
      options: options ?? this.options,
      callback: callback ?? this.callback,
      selectedColor: selectedColor ?? this.selectedColor,
      mainColor: mainColor ?? this.mainColor,
      vertical: vertical ?? this.vertical,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      buttonWidth: buttonWidth ?? this.buttonWidth,
      spaceBetween: spaceBetween ?? this.spaceBetween,
      preSelectedIdx: preSelectedIdx ?? this.preSelectedIdx,
      circular: circular ?? this.circular,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      textStyle: textStyle ?? this.textStyle,
      selectedBorderSide: borderSide ?? this.selectedBorderSide,
      betweenMultiLines: betweenMultiLines ?? this.betweenMultiLines,
      unselectEnabled: allowUnSelect ?? this.unselectEnabled,
    );
  }
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {
  Object? selectedInGroup;

  @override
  void initState() {
    var selectedIdx = widget.preSelectedIdx;
    if (selectedIdx != null) {
      selectedInGroup = widget.options[selectedIdx].value;
    }
  }

  List<Widget> getRadioButtons() {
    List<Widget> radioButtons = [];

    for (RadioOption radioOption in widget.options) {
      radioButtons.add(Padding(
        padding: EdgeInsets.symmetric(
            vertical: widget.vertical ? widget.spaceBetween : 0.0,
            horizontal: widget.vertical ? 0.0 : widget.spaceBetween),
        child: _RadioButton(
          buttonHeight: widget.buttonHeight,
          buttonWidth: widget.buttonWidth,
          colorSelected: widget.selectedColor,
          colorMain: widget.mainColor,
          value: radioOption.value,
          groupValue: selectedInGroup,
          text: radioOption.label,
          unselectEnabled: widget.unselectEnabled,
          onChanged: (value) {
            setState(() {
              selectedInGroup = value;
              if (value == null) {
                widget.callback(RadioOption(null, ""));
              } else {
                widget.callback(radioOption);
              }
            });
          },
          circular: widget.circular,
          textStyle: widget.textStyle,
          borderSide: widget.selectedBorderSide,
        ),
      ));
    }
    return radioButtons;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = getRadioButtons();
    return widget.vertical
        ? Row(
            children: [
              Column(
                mainAxisAlignment:
                    widget.mainAxisAlignment ?? MainAxisAlignment.spaceAround,
                crossAxisAlignment:
                    widget.crossAxisAlignment ?? CrossAxisAlignment.center,
                children: buttons,
              ),
            ],
          )
        : Column(
            children: getRows(widget.multilineNumber, buttons),
          );
  }

  List<Widget> getRows(int number, List<Widget> buttons) {
    if (number == 1) {
      return [
        Row(
            mainAxisAlignment:
                widget.mainAxisAlignment ?? MainAxisAlignment.spaceAround,
            crossAxisAlignment:
                widget.crossAxisAlignment ?? CrossAxisAlignment.center,
            children: buttons)
      ];
    } else {
      List<Widget> rows = [];
      int numPerRow = (buttons.length / number).ceil();
      int start = 0;
      for (var i = 0; i < number; i += 1) {
        rows.add(Padding(
          padding: EdgeInsets.symmetric(vertical: widget.betweenMultiLines / 2),
          child: Row(
            mainAxisAlignment:
                widget.mainAxisAlignment ?? MainAxisAlignment.spaceAround,
            crossAxisAlignment:
                widget.crossAxisAlignment ?? CrossAxisAlignment.center,
            children: buttons.sublist(
                start,
                start + numPerRow > buttons.length
                    ? buttons.length
                    : start + numPerRow),
          ),
        ));
        start = start + numPerRow;
      }
      return rows;
    }
  }
}

class _RadioButton extends StatelessWidget {
  final Object value;
  final Object? groupValue;
  final String text;
  final Function onChanged;
  final Color? colorSelected;
  final Color colorMain;
  final double buttonHeight;
  final double buttonWidth;
  final bool circular;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final bool unselectEnabled;

  const _RadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.text,
    required this.onChanged,
    required this.colorSelected,
    required this.colorMain,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.circular,
    this.textStyle,
    this.borderSide,
    required this.unselectEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return _BasicButton(
      radius: circular ? 100 : 2.5,
      height: buttonHeight,
      width: buttonWidth,
      callback: () {
        if (isSelected && unselectEnabled) {
          onChanged(null);
        } else {
          onChanged(value);
        }
      },
      label: text,
      textStyle: textStyle,
      isSelected: isSelected,
      color: isSelected ? colorSelected : colorMain,
      borderSide: borderSide,
    );
  }
}

class _BasicButton extends StatelessWidget {
  final Function callback;
  final String label;
  final double height;
  final double width;
  final bool isSelected;
  final double radius;
  final Color? color;
  final BorderSide? borderSide;
  final TextStyle? textStyle;

  const _BasicButton(
      {Key? key,
      required this.callback,
      required this.label,
      required this.height,
      required this.width,
      this.radius = 0,
      this.color,
      this.textStyle,
      this.borderSide,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: color ?? Theme.of(context).primaryColor,
          side: borderSide == null || !isSelected
              ? const BorderSide(
                  color: Colors.transparent,
                )
              : borderSide,
        ),
        onPressed: () {
          callback();
        },
        child: Center(
          child: Text(
            label,
            style:
                textStyle ?? const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
