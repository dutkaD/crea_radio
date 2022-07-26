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

A package to create simple radio buttons.

## Features

Render a radio button group:
* with any number of buttons
* vertical or horizontal
* square or round

## Limitations
Currently only supports String as value and button label. An option for RadioGroup is passe via class RadioOption.

## Getting started

To use this plugin, add crea_radio_button as a dependency in your pubspec.yaml file.

## Usage


```dart

final Widget = RadioButtonGroup(
    vertical: true,
    options: [RadioOption("1", "1"), RadioOption("2", "2"), RadioOption("3", "3")],
    callback: (val) {
      print(val);
    }
);


```

## Additional information

Contribute
