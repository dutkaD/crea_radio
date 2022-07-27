import 'package:crea_radio_button/crea_radio_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  RadioButtonGroup simpleRadio = RadioButtonGroup(
      options: [RadioOption("yes", "yes"), RadioOption("no", "no")],
      callback: (val) {
        print(val);
      });

  RadioButtonGroup simpleVerticalRadio = simpleRadio.copyWith(vertical: true);

  testWidgets('Vertical Radio Group builds a Column with two options',
      (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: simpleRadio,
    ));

    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Column), findsNothing);
    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });

  testWidgets('Horizontal Radio Group builds a Row with two options',
      (tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr, child: simpleVerticalRadio));

    expect(find.byType(Row), findsNothing);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });
}
