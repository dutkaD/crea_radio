library crea_radio_button;

import 'package:flutter/material.dart';

/// [RadioOption] - an option passed to the [RadioButtonGroup]
class RadioOption {
  /// an actual value of the option
  final Object value;

  /// label of the option -> is rendered on the radio button
  final String label;

  RadioOption(this.value, this.label);
}

/// Group of radio buttons, where only one option can be selected
/// Requires list of [options] and [callback] function
class RadioButtonGroup extends StatefulWidget {
  /// List of options for the group
  final List<RadioOption> options;

  /// Callback function
  final Function callback;

  /// Color which is used when the button is active (selected)
  final Color? selectedColor;

  /// Color which is used when the button is NOT selected
  final Color mainColor;

  /// Direction of the [RadioButtonGroup].
  /// Default: vertical = false -> horizontal display
  /// Set vertical to true to display options as a column
  final bool vertical;

  /// Height of the option button in the group
  final double buttonHeight;

  /// Width of the option button in the group
  final double buttonWidth;

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
      this.preSelectedIdx})
      : super(key: key);

  @override
  State<RadioButtonGroup> createState() => _RadioButtonGroupState();

  RadioButtonGroup copyWith({
    List<RadioOption>? options,
    Function? callback,
    Color? selectedColor,
    Color? mainColor,
    bool? vertical,
    double? buttonHeight,
    double? buttonWidth,
    double? spaceBetween,
    int? preSelectedIdx,
    bool? circular,
  }) {
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

  List<Widget> getRadioButtons(List<RadioOption> radioOtions, bool vertical) {
    List<Widget> radioButtons = [];

    for (RadioOption radioOption in radioOtions) {
      radioButtons.add(Padding(
        padding: EdgeInsets.symmetric(
            vertical: vertical ? widget.spaceBetween : 0.0,
            horizontal: vertical ? 0.0 : widget.spaceBetween),
        child: _RadioButton(
          buttonHeight: widget.buttonHeight,
          buttonWidth: widget.buttonWidth,
          colorSelected: widget.selectedColor,
          colorMain: widget.mainColor,
          value: radioOption.value,
          groupValue: selectedInGroup,
          text: radioOption.label,
          onChanged: (value) {
            setState(() {
              selectedInGroup = value!;
              widget.callback(radioOption);
            });
          },
          circular: widget.circular,
        ),
      ));
    }
    return radioButtons;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = getRadioButtons(widget.options, widget.vertical);
    return widget.vertical
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttons,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttons);
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return _BasicButton(
      radius: circular ? 100 : 2.5,
      height: buttonHeight,
      width: buttonWidth,
      callback: () {
        onChanged(value);
      },
      label: text,
      color: isSelected ? colorSelected : colorMain,
    );
  }
}

class _BasicButton extends StatelessWidget {
  final Function callback;
  final String label;
  final double height;
  final double width;
  final double radius;
  final Color? color;

  const _BasicButton(
      {Key? key,
      required this.callback,
      required this.label,
      this.height = 50,
      this.width = 150,
      this.radius = 0,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                color ?? Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ))),
        onPressed: () {
          callback();
        },
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
