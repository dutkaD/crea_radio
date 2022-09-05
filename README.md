<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# CreaRadioButton - an easy radio button group
A package to create simple radio buttons.

## Example
![alt text](https://github.com/dutkaD/crea_radio/blob/main/assets/radio1.png?raw=true)

## Features

Render a radio button group:
* with any number of buttons
* vertical or horizontal
* square or round

## Limitations
Currently only supports String as value and button label. An option for RadioGroup is passed via class RadioOption.

## Getting started
To use this plugin, add crea_radio_button as a dependency in your pubspec.yaml file.

## RadioButtonGroup

```dart 
String radioButtonInput = "";

 RadioButtonGroup(
                buttonHeight: 35,
                buttonWidth: 60,
                circular: true,
                mainColor: Colors.grey,
                selectedColor: Colors.pink.shade400,
                preSelectedIdx: defaultOptionIndex,
                options: [
                  RadioOption("10.0", "10"),
                  RadioOption("25.0", "25"),
                  RadioOption("50.0", "50"),
                  RadioOption("100.0", "100")
                ],
                callback: (RadioOption val) {
                  setState(() {
                    selectedOption = val;
                  });
                })


```

### Default selection
By default none of the options is preselected. You can specify index of the option you want to be preselected/
`defaultIdx: 0`


### Default selection
By default none of the options is preselected. You can specify index of the option you want to be preselected/
`preSelectedIdx: 0`

### Callback
Callback function returns the selected `RadioOption`


```dart 
String radioButtonInput = "";

RadioButtonGroup(
                      vertical: true,
                      options: [
                        RadioOption("1", "1"),
                        RadioOption("2", "2"),
                        RadioOption("3", "3")
                      ],
                      buttonHeight: 50,
                      buttonWidth: 50,
                      defaultIdx: defaultRadioIdx,
                      callback: (val) {
                        setState(() {
                          radioButtonInput = val.text;
                        });
                      });


```

## TBD
Selection validation

## Additional information
Contribute here: https://github.com/dutkaD/crea_radio
