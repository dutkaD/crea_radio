import 'package:crea_radio_button/crea_radio_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          child:  RadioButtonGroup(
              vertical: true,
              options: [
                RadioOption("1", "1"),
                RadioOption("2", "2"),
                RadioOption("3", "3")
              ],
              buttonHeight: 50,
              buttonWidth: 50,
              defaultIdx: 2,
              callback: (RadioOption val) {
                print(val.value);
              }),
        ),
      ),
    ),
  ));
}